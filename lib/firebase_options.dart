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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiccfAlOXTV_Ebgl1JlA9NBaTuvGxVtz4',
    appId: '1:426821749244:android:a2a78c1feb5dc7e74cca79',
    messagingSenderId: '426821749244',
    projectId: 'spotify-clone-96e21',
    storageBucket: 'spotify-clone-96e21.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAE0uv1WAEZIzAbBvCVYd47QvCB6gAETN8',
    appId: '1:426821749244:ios:be0c0720d25e22be4cca79',
    messagingSenderId: '426821749244',
    projectId: 'spotify-clone-96e21',
    storageBucket: 'spotify-clone-96e21.appspot.com',
    androidClientId: '426821749244-063ohfbapmse0emlljtnuommtqn8bgb3.apps.googleusercontent.com',
    iosClientId: '426821749244-1mdj0hu6molit1te679aq37n7iiagfmu.apps.googleusercontent.com',
    iosBundleId: 'com.example.getRandomMemes',
  );
}
