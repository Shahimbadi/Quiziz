import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiziz/screen2/loginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDMYIbIszrzMo7y3TIUyJ1QcNerjebXX68",
          appId: "1:998108105927:android:9a880fee107d2213b982e2",
          projectId: "quiziz-f040e",
          storageBucket: "quiziz-f040e.appspot.com",
          messagingSenderId: ''));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
      // const Splash(),
    );
  }
}
