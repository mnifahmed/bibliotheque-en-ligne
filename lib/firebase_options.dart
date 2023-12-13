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
    apiKey: 'AIzaSyDpRhSXho6jevdeWxdMeTA-_GWpE_EjT-g',
    appId: '1:344730367461:web:9fc7ec20c17e254d2eab0c',
    messagingSenderId: '344730367461',
    projectId: 'bibliotheque-institut',
    authDomain: 'bibliotheque-institut.firebaseapp.com',
    storageBucket: 'bibliotheque-institut.appspot.com',
    measurementId: 'G-JYPFE4FE06',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCh312UCXPAyD9uPUWqBBxnXZSR_fxHwFs',
    appId: '1:344730367461:android:3f072dcdd5b8e1232eab0c',
    messagingSenderId: '344730367461',
    projectId: 'bibliotheque-institut',
    storageBucket: 'bibliotheque-institut.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACQ1t_M2TGhx7_3XootXI2r9_8GXOiVe8',
    appId: '1:344730367461:ios:ddd1f02639408c3f2eab0c',
    messagingSenderId: '344730367461',
    projectId: 'bibliotheque-institut',
    storageBucket: 'bibliotheque-institut.appspot.com',
    iosBundleId: 'com.example.bibliotheque',
  );
}
