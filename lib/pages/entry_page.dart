import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owl_app/components/button.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 168, 1.0),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(
                  'Owl.',
                  style: TextStyle(
                      fontSize: 60,
                      color: Color.fromRGBO(95, 46, 14, 1.0)
                  )
              ),
              Image.asset('lib/images/owl.jpg'),
              MyButton(text: 'get started', onTap: () {}),
              const SizedBox(height: 20),
              Text(
                'login',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(214, 99, 93, 1.0),
                ),
              )
            ]
        ),
      ),
    );
  }
}