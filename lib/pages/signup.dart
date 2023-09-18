import 'package:flutter/material.dart';
import 'package:owl_app/components/button.dart';
import 'package:owl_app/components/textfield.dart';

import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    void signUserUp() {}

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
                  const SizedBox(height: 60),
                  MyTextField(
                    controller: nameController,
                    hintText: '  name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: emailController,
                    hintText: '  email',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: usernameController,
                    hintText: '  username',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    hintText: '  password',
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
