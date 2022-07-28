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
    apiKey: 'AIzaSyDkWP759WXJpSRi-ELjuf5DMWI0vJuYsJA',
    appId: '1:265826786340:web:91aa9e02c96e861a7c0cb1',
    messagingSenderId: '265826786340',
    projectId: 'notesapp-8ed32',
    authDomain: 'notesapp-8ed32.firebaseapp.com',
    storageBucket: 'notesapp-8ed32.appspot.com',
    measurementId: 'G-X6X76647K5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcICo7CD_sBccWbty5gmQ4F7MgzF65FmQ',
    appId: '1:265826786340:android:ab14a6ecbc221ea87c0cb1',
    messagingSenderId: '265826786340',
    projectId: 'notesapp-8ed32',
    storageBucket: 'notesapp-8ed32.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBC_6tgyeMT4Z4LlfIbUpGUPH3hMsBRCF0',
    appId: '1:265826786340:ios:4948ca74bce8f97b7c0cb1',
    messagingSenderId: '265826786340',
    projectId: 'notesapp-8ed32',
    storageBucket: 'notesapp-8ed32.appspot.com',
    iosClientId: '265826786340-1h4ek284e9q52n5isv6mrll6msjl2nib.apps.googleusercontent.com',
    iosBundleId: 'com.example.notesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBC_6tgyeMT4Z4LlfIbUpGUPH3hMsBRCF0',
    appId: '1:265826786340:ios:4948ca74bce8f97b7c0cb1',
    messagingSenderId: '265826786340',
    projectId: 'notesapp-8ed32',
    storageBucket: 'notesapp-8ed32.appspot.com',
    iosClientId: '265826786340-1h4ek284e9q52n5isv6mrll6msjl2nib.apps.googleusercontent.com',
    iosBundleId: 'com.example.notesApp',
  );
}