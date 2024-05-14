// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyD1XnB2_YAmhCYUK7N7tLR56Evh5VwKsP0',
    appId: '1:314365297711:web:fa1e941eb348378b11b2da',
    messagingSenderId: '314365297711',
    projectId: 'e-trash-point',
    authDomain: 'e-trash-point.firebaseapp.com',
    storageBucket: 'e-trash-point.appspot.com',
    measurementId: 'G-1WZZ5ECGWR',
    databaseURL: 'https://e-trash-point-default-rtdb.asia-southeast1.firebasedatabase.app/',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwPlIEOXbZnrXcE1ji_haEiOQgjKidlcM',
    appId: '1:314365297711:android:c5924ee293f4e08811b2da',
    messagingSenderId: '314365297711',
    projectId: 'e-trash-point',
    storageBucket: 'e-trash-point.appspot.com',
    authDomain: 'e-trash-point.firebaseapp.com',
    databaseURL: 'https://e-trash-point-default-rtdb.asia-southeast1.firebasedatabase.app/',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAv5g-mM56VHV9jF9lR9CAb_kSq4PYGO7Q',
    appId: '1:314365297711:ios:1a06781a3e38804011b2da',
    messagingSenderId: '314365297711',
    projectId: 'e-trash-point',
    storageBucket: 'e-trash-point.appspot.com',
    iosBundleId: 'com.example.firstProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAv5g-mM56VHV9jF9lR9CAb_kSq4PYGO7Q',
    appId: '1:314365297711:ios:1a06781a3e38804011b2da',
    messagingSenderId: '314365297711',
    projectId: 'e-trash-point',
    storageBucket: 'e-trash-point.appspot.com',
    iosBundleId: 'com.example.firstProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD1XnB2_YAmhCYUK7N7tLR56Evh5VwKsP0',
    appId: '1:314365297711:web:9d80cf4ebd76525d11b2da',
    messagingSenderId: '314365297711',
    projectId: 'e-trash-point',
    authDomain: 'e-trash-point.firebaseapp.com',
    storageBucket: 'e-trash-point.appspot.com',
    measurementId: 'G-V4L16N795B',
  );
}