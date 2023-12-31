// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBNXWL0ISQdSs6WMUfSwg514DRWS1uOPUA',
    appId: '1:1005517361793:web:06fa8a2a78a86cf6f53380',
    messagingSenderId: '1005517361793',
    projectId: 'owl-app-42265',
    authDomain: 'owl-app-42265.firebaseapp.com',
    storageBucket: 'owl-app-42265.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6HJQm9jB2LuSN1cWCD_KKHHK0WcHb6bU',
    appId: '1:1005517361793:android:c712f612bd81550cf53380',
    messagingSenderId: '1005517361793',
    projectId: 'owl-app-42265',
    storageBucket: 'owl-app-42265.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsdstYod-ssvEjqobwzDYlo9h2gSlS3YA',
    appId: '1:1005517361793:ios:b0d252b1983c757cf53380',
    messagingSenderId: '1005517361793',
    projectId: 'owl-app-42265',
    storageBucket: 'owl-app-42265.appspot.com',
    iosBundleId: 'com.example.owlApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDsdstYod-ssvEjqobwzDYlo9h2gSlS3YA',
    appId: '1:1005517361793:ios:463bc725eace7b45f53380',
    messagingSenderId: '1005517361793',
    projectId: 'owl-app-42265',
    storageBucket: 'owl-app-42265.appspot.com',
    iosBundleId: 'com.example.owlApp.RunnerTests',
  );
}
