import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owl_app/components/button.dart';
import 'package:owl_app/components/textfield.dart';
import 'package:owl_app/pages/homepage.dart';
import 'package:owl_app/pages/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _visible = false;
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void signUserIn() async {
      showDialog(
          context: context,
          builder: (context) => const Center(
              child: CircularProgressIndicator(),
          ),
      );
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          setState(() {
            _visible = true;
            _errorText = 'incorrect email or password';
          });
        } else if (e.code == 'channel-error') {
          setState(() {
            _visible = true;
            _errorText = 'missing email or password';
          });
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Owl.',
                  style: TextStyle(
                      fontSize: 60, color: Color.fromRGBO(95, 46, 14, 1.0)),
                ),
                const SizedBox(height: 60),
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
                const SizedBox(height: 40),
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
                const SizedBox(height: 15),
                MyButton(
                  text: 'login',
                  padding: 130.0,
                  onTap: signUserIn,
                ),
                const SizedBox(height: 170),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/images/owl_nobg.png',
                        height: 150,
                        width: 150,
                      ),
                      Row(
                        children: [
                          Text('Doesn\'t have an account? ',
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                              );
                            },
                            child: Text(
                              'Sign Up',
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
