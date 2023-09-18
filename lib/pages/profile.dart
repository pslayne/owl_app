import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'entry_page.dart';

class Profile extends StatefulWidget {
  const Profile ({ super.key });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Profile'),
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const EntryPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}