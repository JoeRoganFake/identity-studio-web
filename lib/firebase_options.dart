import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBRJ5O3IO4fFbTOk5q1G9G42mCAIWWbgy0",
    authDomain: "identity-studio.firebaseapp.com",
    projectId: "identity-studio",
    storageBucket: "identity-studio.firebasestorage.app",
    messagingSenderId: "335344413188",
    appId: "1:335344413188:web:830f485164e1b06844e351",
    measurementId: "G-QBTBR6MXXD"
  );

  static FirebaseOptions get currentPlatform {
    return web;
  }
}
