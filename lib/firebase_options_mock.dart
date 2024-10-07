import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "FAKE_API_KEY",
    appId: "FAKE_APP_ID",
    messagingSenderId: 'FAKE_MESSAGING_SENDER_ID',
    projectId: 'loginflutter-34c6d',
    storageBucket: 'loginflutter-34c6d.appspot.com',
  );
}
