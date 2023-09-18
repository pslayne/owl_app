import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owl_app/components/button.dart';
import 'package:owl_app/components/textfield.dart';
import 'package:owl_app/pages/entry_page.dart';
import 'package:owl_app/pages/profile.dart';
import 'package:owl_app/pages/search.dart';

import '../components/icon_button.dart';
import '../components/icon_textfield.dart';
import '../components/hoot.dart';
import 'feed.dart';
import 'notification.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Widget> list = [Feed(), Notifications(), Search(), Profile()];
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
          'Likes': [],
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
        ],
      ),
      body: list[_selectedIndex],
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
