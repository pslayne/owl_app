import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/hoot.dart';
import '../components/icon_button.dart';
import '../components/icon_textfield.dart';
import '../firebase_storage.dart';

class Feed extends StatefulWidget {
  const Feed({ super.key });

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final textController = TextEditingController();
  List<String> images = <String>[];
  List<File> files = [];
  final user = FirebaseAuth.instance.currentUser!;

  uploadImages() async {
    for(File f in files) {
      String url = await StorageClient.uploadImageToFirebase(f, '${user.email}', profile: false);
      images.add(url);
    }
  }

  void post() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    Reference reference = FirebaseStorage.instance.ref(
        'uploads/profilePictures/${user.email}.jpg');
    String image = await reference.getDownloadURL();

    if(textController.text.isNotEmpty) {
      await uploadImages();
      FirebaseFirestore.instance.collection('Hoots').add({
        'UserEmail': user.email,
        'Message': textController.text,
        'Timestamp': Timestamp.now(),
        'profilePicUrl': image,
        'Likes': [],
        'Geopoint': const GeoPoint(0.0, 0.0),
        'Images': images
      });
    }

    Navigator.pop(context);
    setState(() {
      textController.clear();
      files.clear();
      images.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                  stream:
                  FirebaseFirestore.instance
                      .collection("Hoots")
                      .orderBy(
                    "Timestamp",
                    descending: true,
                  ).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data!.docs[index];
                          return Hoot(
                              message: post['Message'],
                              user: post['UserEmail'],
                              hootId: post.id,
                              likes: List<String>.from(post['Likes'] ?? []),
                              profilePicUrl: post['profilePicUrl'],
                              images: List<String>.from(post['Images'] ?? []),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    return const Center (
                      child: CircularProgressIndicator(),
                    );
                  },
                )),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MyIconTextField(
                    controller: textController,
                    hintText: 'Share your thougths...',
                    obscureText: false,
                    padding: 8,
                    icon: Icons.send,
                    action: post,
                  ),
                ),
              ],
            ),
            Container(
              height: 55,
              child: Row(
                children: [
                  SizedBox(width: 25),
                  GestureDetector(
                    child: Icon(Icons.image_outlined, color: Color.fromRGBO(214, 99, 93, 1.0)),
                    onTap: () {
                      showModalBottomSheet(
                        constraints: BoxConstraints(
                            maxHeight: 100
                        ),
                        context: context,
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 15),
                                MyIconButton(
                                  icon: Icons.image,
                                  onTap: () {
                                    getImageFrom(ImageSource.gallery);
                                  },
                                  padding: 10,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'gallery',
                                  style: TextStyle(
                                    color: Color.fromRGBO(95, 46, 14, 0.8),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 40),
                            Column(
                              children: [
                                SizedBox(height: 15),
                                MyIconButton(
                                  icon: Icons.camera_alt,
                                  onTap: () {
                                    getImageFrom(ImageSource.camera);
                                  },
                                  padding: 10,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'camera',
                                  style: TextStyle(
                                    color: Color.fromRGBO(95, 46, 14, 0.8),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    child: Icon(Icons.place_outlined, color: Color.fromRGBO(214, 99, 93, 1.0)),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    child: Icon(Icons.delete_outline, color: Color.fromRGBO(214, 99, 93, 1.0)),
                    onTap: () {
                      setState(() {
                        textController.clear();
                        files.clear();
                        images.clear();
                      });
                    },
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        return ImageTile(image: files[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  getImageFrom(ImageSource source) async {
    Navigator.pop(context);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        files.add(File(pickedFile.path));
      });
    }
  }
}

class ImageTile extends StatelessWidget {
  File image;
  ImageTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: Color.fromRGBO(217, 217, 217, 1.0)),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}