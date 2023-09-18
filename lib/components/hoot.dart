import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owl_app/components/like.dart';

class Hoot extends StatefulWidget {
  final String message;
  final String user;
  final String hootId;
  final List<String> likes;
 // final String time;

  const Hoot({
    super.key,
    required this.message,
    required this.user,
    required this.hootId,
    required this.likes,

    //required this.time,
  });

  @override
  State<Hoot> createState() => _HootState();
}

class _HootState extends State<Hoot> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.length > 0 ? widget.likes.contains(user.email) : false;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = FirebaseFirestore.instance.collection('User Posts').doc(widget.hootId);

    if(isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([user.email]),
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([user.email]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // profile pic
      decoration: BoxDecoration(
        border: Border.all(
            color: Color.fromRGBO(95, 46, 14, 0.15)
        ),
          borderRadius: BorderRadius.circular(10.0)
        ),
        margin: EdgeInsets.only(top: 15, left: 8, right: 8),
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            // profile pic
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  color: Color.fromRGBO(95, 46, 14, 0.8)
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.person, color: Colors.white,),
            ),
            SizedBox(width: 15),
            // texto
            SizedBox(
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.user,
                      style: TextStyle(
                        color: Color.fromRGBO(95, 46, 14, 0.4),
                      )
                  ),
                  SizedBox(height: 5),
                  Text(
                      widget.message,
                      style: TextStyle(
                        color: Color.fromRGBO(95, 46, 14, 1.0),
                      )
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            // actions
            Column(
              children: [
                SizedBox(height: 25),
                Row(
                  children: [
                    LikeButton(
                      onTap: toggleLike,
                      isLiked: isLiked,
                    ),
                    SizedBox(width: 5),
                    Text(
                      widget.likes.length.toString(),
                      style: TextStyle(
                        color: isLiked ? Colors.red : Color.fromRGBO(95, 46, 14, 0.4),
                        fontSize: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      );
  }
}