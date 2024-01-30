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
    apiKey: 'AIzaSyB9UF4tjVbOS00WIVZ-lX56xpL6MvtnvmU',
    appId: '1:436107110517:web:0e2339d6965dec1a14b03c',
    messagingSenderId: '436107110517',
    projectId: 'koreanlms-f3ced',
    authDomain: 'koreanlms-f3ced.firebaseapp.com',
    storageBucket: 'koreanlms-f3ced.appspot.com',
    measurementId: 'G-XQ6ZGGFKYH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApbgruFaGuzRYi0Q2v7Js2_8nLMdSeAUs',
    appId: '1:436107110517:android:2f7c6c543c1b9e3714b03c',
    messagingSenderId: '436107110517',
    projectId: 'koreanlms-f3ced',
    storageBucket: 'koreanlms-f3ced.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeK7Z-v4B3xTVW0gTfF3NDVNSVpOxm3Vo',
    appId: '1:436107110517:ios:8500db99a4f5549114b03c',
    messagingSenderId: '436107110517',
    projectId: 'koreanlms-f3ced',
    storageBucket: 'koreanlms-f3ced.appspot.com',
    iosBundleId: 'com.koreanlmsflutter.koreanlmsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCeK7Z-v4B3xTVW0gTfF3NDVNSVpOxm3Vo',
    appId: '1:436107110517:ios:9f25c5f0d8f28d3114b03c',
    messagingSenderId: '436107110517',
    projectId: 'koreanlms-f3ced',
    storageBucket: 'koreanlms-f3ced.appspot.com',
    iosBundleId: 'com.koreanlmsflutter.koreanlmsapp.RunnerTests',
  );
}
