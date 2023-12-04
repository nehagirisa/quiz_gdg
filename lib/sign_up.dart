import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quiz_gdg/Quiz/Quiz.dart';
import 'package:quiz_gdg/servey.dart';

import 'package:quiz_gdg/widget/custome_textfield.dart';
import 'package:quiz_gdg/widget/footer/footer.dart';
import 'package:velocity_x/velocity_x.dart';

class sign_up extends StatefulWidget {
  sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  /// Controller for updating translation input text.
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passWordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  Future Upload() async {
    setState(() {});
  }

  Future SignUP() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passWordController.text)
        .then((value) {
      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
        'email': value.user!.email,
        'name': _nameController.text,
        //'phone': _phoneController.text,
        // 'address': _addDressController.text
      });
    });
  }

  String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 184, 47),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const Center(
              child: Text(
            "Mindfulness for Developers",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
          )),
          Image.asset(
            'assets/logo1.png',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 248, 248, 248),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
          
            ),
          ),
          CustomeTextField(
            hintText: "Enter your name",
            contoller: _nameController,
          ),
          CustomeTextField(
            hintText: "Enter your email",
            contoller: _emailController,
          ),
          CustomeTextField(
            hintText: "Enter your password",
            contoller: _passWordController,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                  onPressed: () async {
                    SignUP();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MentalHealth()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('user is added'),
                      ),
                    );
                  },
                  child: Text(
                    "Join",
                    style: Theme.of(context).textTheme.titleMedium,
                  ))),
          const Spacer(),
          const Footer(),
        ]),
      ),
    );
  }
}
