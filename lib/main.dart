import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_gdg/servey.dart';

import 'package:quiz_gdg/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAYiGyuFT0tCLWAfMa8DUm230BLslusRB8",
          authDomain: "quiz-357ec.firebaseapp.com",
          projectId: "quiz-357ec",
          storageBucket: "quiz-357ec.appspot.com",
          messagingSenderId: "522613745788",
          appId: "1:522613745788:web:2af4c48b4dea6b5f70c1f9",
          measurementId: "G-PNLYX424QB"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        //  theme:
        // ThemeData(flutter pub upgrade

        //   primaryColor: Colors.black,
        //   //primarySwatch: Colors.black,

        // ),
        home: MentalHealth());
  }
}
