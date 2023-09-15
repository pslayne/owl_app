import 'package:flutter/material.dart';
import 'package:owl_app/components/button.dart';
import 'package:owl_app/components/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    void signUserIn() {}

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Owl.',
                style: TextStyle(
                    fontSize: 60, color: Color.fromRGBO(95, 46, 14, 1.0)),
              ),
              const SizedBox(height: 200),
              MyTextField(
                controller: usernameController,
                hintText: '  username',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: passwordController,
                hintText: '  password',
                obscureText: true,
              ),
              const SizedBox(height: 25),
              MyButton(
                text: 'login',
                padding: 300.0,
                onTap: signUserIn,
              ),
              const SizedBox(height: 250),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 110),
                child: Row(
                  children: [
                    Image.asset(
                      'lib/images/owl_nobg.png',
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(width: 25),
                    Row(
                      children: [
                        Text('Doesn\'t have an account? ',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        Text('Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(214, 99, 93, 1.0),
                              fontSize: 20,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
