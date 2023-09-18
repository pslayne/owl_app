import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final double padding;
  const MyButton({super.key, required this.text, required this.padding, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(214, 99, 93, 1.0),
          borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
          child: Text(
            text,
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