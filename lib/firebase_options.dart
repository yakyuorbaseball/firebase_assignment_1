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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCCYAjgdyLCu6mXFVRAKMPhad2hd-82Z-c',
    appId: '1:1036628057585:web:29f50e92847a7bc466f850',
    messagingSenderId: '1036628057585',
    projectId: 'fir-tutorial-1d996',
    authDomain: 'fir-tutorial-1d996.firebaseapp.com',
    storageBucket: 'fir-tutorial-1d996.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrv4St61f6aE8_hHjt4uspTHlLmb8-IJk',
    appId: '1:1036628057585:android:6cfbe9640f25426866f850',
    messagingSenderId: '1036628057585',
    projectId: 'fir-tutorial-1d996',
    storageBucket: 'fir-tutorial-1d996.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZFvaJRN9EKVHPvcD3ir2eolTWUHSc5fg',
    appId: '1:1036628057585:ios:5065968cd576df9f66f850',
    messagingSenderId: '1036628057585',
    projectId: 'fir-tutorial-1d996',
    storageBucket: 'fir-tutorial-1d996.appspot.com',
    iosClientId: '1036628057585-jn8fjb93pfljvn7fgiamgm8l6ndd564v.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseExercise1',
  );
}