import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class StorageClient {
  final storage = firebase_storage.FirebaseStorage.instance;

  //send image to firebase
  static Future<String?> uploadImageToFirebase(File imageFile, String email) async {
    try {
      String filePath = imageFile.path;
      File file = File(filePath);

      try {
        String? path;
        String fileExtension = filePath.split('.').last;

        path = 'uploads/profilePictures/$email.$fileExtension';

        firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref(path);
        // upload

        await reference.putFile(file);

        // get uploaded object link
        String image = await reference.getDownloadURL();
        return image;
      } on firebase_core.FirebaseException catch (e) {
        print('##################################################');
        print(e);
        print('##################################################');
      }
    } catch (e) {
      print('##################################################');
      print(e);
      print('##################################################');
    }

    return null;
  }
}