import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'components/icon_button.dart';

File modalImagePicker(context) {
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
                return getImageFrom(ImageSource.gallery, context);
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
                return getImageFrom(ImageSource.camera, context);
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
  return File('');
}

getImageFrom(ImageSource src, context) async {
  Navigator.pop(context);
  XFile? pickedFile = await ImagePicker().pickImage(
    source: src,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
      await pickedFile.readAsBytes();
      return File(pickedFile.path);
  }
}