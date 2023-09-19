import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:owl_app/components/button.dart';
import 'package:owl_app/components/textfield.dart';
import 'package:image_picker/image_picker.dart';
import '../firebase_storage.dart';

import '../components/icon_button.dart';
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
  File profilePic = File('');
  final storageRef = FirebaseStorage.instance.ref();
  final usernameController = TextEditingController();
  final displayNameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Widget getChild() {
    if(profilePic.path.isEmpty) {
      return Icon(
        Icons.image_search,
        color: Color.fromRGBO(95, 46, 14, 0.6),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.file(
          profilePic,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 30),
                  // get profile picture
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 15),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(color: Color.fromRGBO(217, 217, 217, 1.0)),
                            color: Colors.white,
                          ),
                          child: getChild(),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            constraints: BoxConstraints(
                              maxHeight: 100
                            ),
                            context: context,
                            builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 15),
                                    MyIconButton(
                                      icon: Icons.image,
                                      onTap: () {
                                        getImageFrom(ImageSource.gallery);
                                      },
                                      padding: 10,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                        'gallery',
                                        style: TextStyle(
                                          color: Color.fromRGBO(95, 46, 14, 0.8),
                                        ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 40),
                                Column(
                                  children: [
                                    SizedBox(height: 15),
                                    MyIconButton(
                                      icon: Icons.camera_alt,
                                      onTap: () {
                                        getImageFrom(ImageSource.camera);
                                      },
                                      padding: 10,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                        'camera',
                                        style: TextStyle(
                                          color: Color.fromRGBO(95, 46, 14, 0.8),
                                        ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        width: 245,
                        height: 120,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyTextField(
                                controller: usernameController,
                                hintText: 'username',
                                obscureText: false,
                                padding: 2.0,
                              ),
                              SizedBox(height: 5),
                              MyTextField(
                                controller: displayNameController,
                                hintText: 'display name',
                                obscureText: false,
                                padding: 2.0,
                              ),
                            ],
                          ),
                      ),

                    ],
                  ),
                  MyTextField(
                    controller: bioController,
                    hintText: 'bio',
                    obscureText: false,
                    padding: 15.0,
                  ),
                  const SizedBox(height: 30),
                  MyTextField(
                    controller: emailController,
                    hintText: 'email',
                    obscureText: false,
                    padding: 15.0,
                  ),
                  const SizedBox(height: 5),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'password',
                    obscureText: true,
                    padding: 15.0,
                  ),
                  const SizedBox(height: 5),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'confirm password',
                    obscureText: true,
                    padding: 15.0,
                  ),
                  const SizedBox(height: 10),
                  Opacity(
                    opacity: _visible ? 1.0 : 0.0,
                    child: Text(
                      _errorText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(214, 99, 93, 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    text: 'sign up',
                    padding: 120.0,
                    onTap: signUserUp,
                  ),
                  const SizedBox(height: 50),
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
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      String? url = await StorageClient.uploadImageToFirebase(profilePic, emailController.text.trim());

      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
            'username': usernameController.text.trim(),
            'displayname': displayNameController.text.trim(),
            'bio': bioController.text.trim(),
            'profilePicUrl': url ?? '',
            'coverPicUrl': '',
          });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } on FirebaseAuthException catch(e) {
      Navigator.pop(context);
      if(e.code == 'invalid-email') {
        setState(() {
          _visible = true;
          _errorText = 'invalid email';
        });
        return;
      }
      else if (e.code == 'email-already-in-use') {
        setState(() {
          _visible = true;
          _errorText = 'this email is already registered, login instead';
        });
        return;
      }
    }
  }

  getImageFrom(ImageSource source) async {
    Navigator.pop(context);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        profilePic = File(pickedFile.path);
      });
    }
  }
}
