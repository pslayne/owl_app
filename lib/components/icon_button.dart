import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final double padding;
  const MyIconButton({super.key, required this.icon, required this.padding, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(13),
          margin: EdgeInsets.symmetric(horizontal: padding),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(214, 99, 93, 1.0),
              borderRadius: BorderRadius.circular(25)
          ),
          child: Center(
              child: Icon(icon, color: Colors.white,),
          )
      ),
    );
  }
}