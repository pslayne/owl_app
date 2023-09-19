import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/hoot.dart';
import 'entry_page.dart';

class Profile extends StatefulWidget {
  const Profile ({ super.key });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: usersRef.doc(user.email).get(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  final userData = snapshot.data!.data() as Map<String, dynamic>;
                  return Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 150,
                              width: 400,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(95, 46, 14, 0.05)),
                              ),
                              child: (userData['coverPicUrl'] == '') ? Icon(Icons.image, color: Colors.white) : Image.network(userData['coverPicUrl']),
                            ),
                            Positioned(
                              bottom: -50,
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Color.fromRGBO(95, 46, 14, 1.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    userData['profilePicUrl'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 55),
                        Text(
                          '${userData['displayname']}',
                          style: TextStyle(
                              color:  Color.fromRGBO(95, 46, 14, 1.0),
                              fontSize: 18
                          ),
                        ),
                        Text(
                          '${userData['username']}',
                          style: TextStyle(
                              color:  Color.fromRGBO(95, 46, 14, 0.4),
                              fontSize: 14
                          ),
                        ),
                        Text(
                          '${userData['bio']}',
                          style: TextStyle(
                              color:  Color.fromRGBO(95, 46, 14, 0.8),
                              fontSize: 14
                          ),
                        ),
                        Divider(color:  Color.fromRGBO(95, 46, 14, 0.05)),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else {
                  return const Icon(Icons.person, color: Colors.white);
                }
              },
            ),
            Expanded(
                child: StreamBuilder(
                  stream:
                  FirebaseFirestore.instance
                      .collection("Hoots")
                      .where('UserEmail', isEqualTo: user.email)
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
          ],
        ),
      )
    );
  }

}