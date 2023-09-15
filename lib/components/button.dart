import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, required this.text, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10
        ),
        margin: const EdgeInsets.symmetric(horizontal: 80.0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(214, 99, 93, 1.0),
          borderRadius: BorderRadius.circular(25)
        ),
        child: const Center(
          child: Text(
            'get started',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            )
          )
        )
      ),
    );
  }
}