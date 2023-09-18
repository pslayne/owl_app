import 'package:flutter/material.dart';

class Hoot extends StatelessWidget {
  final String message;
  final String user;
 // final String time;

  const Hoot({
    super.key,
    required this.message,
    required this.user,
    //required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Color.fromRGBO(95, 46, 14, 0.15)
        ),
          borderRadius: BorderRadius.circular(10.0)
        ),
        margin: EdgeInsets.only(top: 15, left: 8, right: 8),
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  color: Color.fromRGBO(95, 46, 14, 0.8)
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.person, color: Colors.white,),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user,
                  style: TextStyle(
                      color: Color.fromRGBO(95, 46, 14, 0.4),
                  )
                ),
                SizedBox(height: 5),
                Text(
                    message,
                    style: TextStyle(
                      color: Color.fromRGBO(95, 46, 14, 1.0),
                    )
                ),
              ],
            )
          ],
        ),
      );
  }

}