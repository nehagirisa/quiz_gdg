
import 'package:flutter/material.dart';
import 'package:quiz_gdg/Quiz/Quiz.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyB2sRX5l0dv8eQHjVbBa7ZgUXd_WPauA5w",
    authDomain: "microbiomesuperhero-526b1.firebaseapp.com",
    projectId: "microbiomesuperhero-526b1",
    storageBucket: "microbiomesuperhero-526b1.appspot.com",
    messagingSenderId: "605008213075",
    appId: "1:605008213075:web:0255700d053590963082a6",
    measurementId: "G-TRCY9XGD65",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //  theme:
      // ThemeData(flutter pub upgrade

      //   primaryColor: Colors.black,
      //   //primarySwatch: Colors.black,

      // ),
      home: QuizApp()
    );
  }
}

