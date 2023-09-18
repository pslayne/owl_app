import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owl_app/components/button.dart';
import 'package:owl_app/components/textfield.dart';
import 'package:owl_app/pages/entry_page.dart';

import '../components/icon_button.dart';
import '../components/icon_textfield.dart';
import '../components/post.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    void post() {

      if(textController.text.isNotEmpty) {
        FirebaseFirestore.instance.collection('User Posts').add({
          'UserEmail': user.email,
          'Message': textController.text,
          'Timestamp': Timestamp.now(),
        });
      }

      setState(() {
        textController.clear();
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Owl',
          style: TextStyle(
            fontSize: 40,
            color: Color.fromRGBO(95, 46, 14, 1.0),
          ),
        ),
        actions: [
          Image.asset('lib/images/owl_heart_nobg.png'),
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
              SizedBox(height: 10,),
            ],
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(214, 99, 93, 1.0),
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromRGBO(95, 46, 14, 0.5),
      ),
    );
  }
}
