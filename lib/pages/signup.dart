import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owl_app/components/button.dart';
import 'package:owl_app/components/textfield.dart';

import 'homepage.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _visible = false;
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    void signUserUp() async {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      if(passwordController.text.length < 6) {
        Navigator.pop(context);
        setState(() {
          _visible = true;
          _errorText = 'password should have at least 6 characteres';
        });
        return;
      }
      else if(passwordController.text != confirmPasswordController.text) {
        Navigator.pop(context);
        setState(() {
          _visible = true;
          _errorText = 'passwords don\'t match';
        });
        return;
      }

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } on FirebaseAuthException catch(e) {
        Navigator.pop(context);
        print(e);
        if(e.code == 'invalid-email') {
          setState(() {
            _visible = true;
            _errorText = 'invalid email';
          });
          return;
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Owl.',
                    style: TextStyle(
                      fontSize: 60,
                      color: Color.fromRGBO(95, 46, 14, 1.0),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Opacity(
                    opacity: _visible ? 1.0 : 0.0,
                    child: Text(
                      _errorText,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(214, 99, 93, 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // MyTextField(
                  //   controller: nameController,
                  //   hintText: '  name',
                  //   obscureText: false,
                  // ),
                  // const SizedBox(height: 10),
                  MyTextField(
                    controller: emailController,
                    hintText: '  email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    hintText: '  password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: '  confirm password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  MyButton(
                    text: 'sign up',
                    padding: 120.0,
                    onTap: signUserUp,
                  ),
                  const SizedBox(height: 100),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        Image.asset(
                          'lib/images/owl_nobg.png',
                          height: 150,
                          width: 150,
                        ),
                        Row(
                          children: [
                            Text('Already have an account? ',
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(214, 99, 93, 1.0),
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
