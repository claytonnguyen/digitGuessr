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
    apiKey: 'AIzaSyBbwjIn5_VbGlgtV02AX6CKYMd2JzEayGI',
    appId: '1:969196261707:web:598c563fdcf2a4564ad8ce',
    messagingSenderId: '969196261707',
    projectId: 'digitguessr',
    authDomain: 'digitguessr.firebaseapp.com',
    storageBucket: 'digitguessr.appspot.com',
    measurementId: 'G-GYK6DG9G79',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLVKVNODAM5KPq5Thm8W0qBvRrkfRVr2U',
    appId: '1:969196261707:android:44d8c953659b1ccb4ad8ce',
    messagingSenderId: '969196261707',
    projectId: 'digitguessr',
    storageBucket: 'digitguessr.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqz3K1hTwCaIiuA2-kkiYIgP22jhTIlqI',
    appId: '1:969196261707:ios:6544f35e667834524ad8ce',
    messagingSenderId: '969196261707',
    projectId: 'digitguessr',
    storageBucket: 'digitguessr.appspot.com',
    iosClientId: '969196261707-v8i2mv7436odhodfpgi3l8b6iorffqgk.apps.googleusercontent.com',
    iosBundleId: 'com.example.digitguessr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqz3K1hTwCaIiuA2-kkiYIgP22jhTIlqI',
    appId: '1:969196261707:ios:6544f35e667834524ad8ce',
    messagingSenderId: '969196261707',
    projectId: 'digitguessr',
    storageBucket: 'digitguessr.appspot.com',
    iosClientId: '969196261707-v8i2mv7436odhodfpgi3l8b6iorffqgk.apps.googleusercontent.com',
    iosBundleId: 'com.example.digitguessr',
  );
}