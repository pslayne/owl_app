import 'package:flutter/material.dart';

class MyIconTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final double padding;
  final IconData icon;
  final Function()? action;

  const MyIconTextField(
      {super.key,
        required this.controller,
        required this.hintText,
        required this.obscureText,
        required this.padding,
        required this.icon,
        required this.action
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Color.fromRGBO(217, 217, 217, 1.0)),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Color.fromRGBO(214, 99, 93, 1.0)),
                borderRadius: BorderRadius.circular(30.0),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color.fromRGBO(95, 46, 14, 0.6),
              ),
              suffixIcon: IconButton(
                icon: Icon(icon),
                color: Color.fromRGBO(214, 99, 93, 1.0),
                onPressed: action,
              ),
          ),
        ));
  }
}
