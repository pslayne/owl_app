import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:owl_app/components/like.dart';

class Hoot extends StatefulWidget {
  final String message;
  final String user;
  final String hootId;
  final List<String> likes;
  final String profilePicUrl;
  final List<String> images;

  Hoot({
    super.key,
    required this.message,
    required this.user,
    required this.hootId,
    required this.likes,
    required this.profilePicUrl,
    required this.images,
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
    isLiked = widget.likes.isNotEmpty ? widget.likes.contains(user.email) : false;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = FirebaseFirestore.instance.collection('Hoots').doc(widget.hootId);

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

  Widget images() {
    if(widget.images.isNotEmpty) {
      return Row(
        children: [
          SizedBox(width: 55),
          Expanded(
            child: Container(
              height: 120,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return ImageTile(image: widget.images[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      );
    }
    return SizedBox(height: 0);
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
        child: Column(
          children: [
            Row(
              children: [
                // profile pic
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Color.fromRGBO(95, 46, 14, 1.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      widget.profilePicUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
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
              ],
            ),
            images(),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
            ),
          ],
        )
      );
  }
}


class ImageTile extends StatelessWidget {
  String image;
  ImageTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromRGBO(217, 217, 217, 1.0)),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}