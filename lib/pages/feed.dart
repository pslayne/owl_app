import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/hoot.dart';
import '../components/icon_textfield.dart';

class Feed extends StatefulWidget {
  const Feed({ super.key });

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final textController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  void post() {
    if(textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('User Posts').add({
        'UserEmail': user.email,
        'Message': textController.text,
        'Timestamp': Timestamp.now(),
        'Likes': [],
      });
  }

  setState(() {
    textController.clear();
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
                      .collection("User Posts")
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
                              likes: List<String>.from(post['Likes'] ?? [])
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
            SizedBox(height: 10),
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
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}