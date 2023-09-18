import 'package:flutter/material.dart';
import 'package:owl_app/components/button.dart';
import 'package:owl_app/pages/signup.dart';

import 'login.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 168, 1.0),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Owl.',
                  style: TextStyle(
                      fontSize: 60, color: Color.fromRGBO(95, 46, 14, 1.0))),
              Image.asset('lib/images/owl.jpg'),
              MyButton(
                text: 'get started',
                padding: 80.0,
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    );
                  },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: Text(
                  'login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(214, 99, 93, 1.0),
                    fontSize: 20,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
