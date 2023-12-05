
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:quiz_gdg/servey.dart';
import 'package:quiz_gdg/widget/custome_textfield.dart';
import 'package:quiz_gdg/widget/footer/footer.dart';


class sign_up extends StatefulWidget {
  sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 184, 47),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Center(
                child: Text(
                  "Mindfulness for Developers",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                obscureText: false,
              ),
              CustomeTextField(
                hintText: "Enter your email",
                contoller: _emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(
                          r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                obscureText: false,
              ),
              // CustomeTextField(
              //   hintText: "Enter your password",

              //   contoller: _passWordController,
              //   obscureText: true,
              //   validator: (value) {
              //     if (value.isEmpty) {
              //       return 'Please enter your password';
              //     } else if (value.length < 6) {
              //       return 'Password must be at least 6 characters long';
              //     }
              //     return null;
              //   },

              // ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextButton(
                  onPressed: () async {
                    // if (_validateForm()) {
                    if (_emailController.text == "" &&
                        _nameController.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Fill the Details'),
                        ),
                      );
                    } else {
                      await _signUp();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MentalHealth()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('User is added'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Join",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: const Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    return _nameController.text.isNotEmpty && _emailController.text.isNotEmpty;
    //  _passWordController.text.isNotEmpty;
  }

  Future<void> _signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: "1234578",
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'email': FirebaseAuth.instance.currentUser!.email,
        'name': _nameController.text,
      });
    } catch (error) {
      print('Error: $error');
      // Handle error here
    }
  }
}
