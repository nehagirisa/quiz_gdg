// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Quizdata extends StatefulWidget {
  Quizdata({super.key});

  @override
  State<Quizdata> createState() => _QuizdataState();
}

class _QuizdataState extends State<Quizdata> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController questionController = TextEditingController();

  TextEditingController correctAnserController = TextEditingController();

  TextEditingController optionsController = TextEditingController();
  List<String> arrayFieldValues = [];

  @override
  void dispose() {
    questionController.dispose();
    correctAnserController.dispose();
  
    optionsController.dispose();

    super.dispose();
  }

  // Add a value to the array field
  void addArrayFieldValue() {
    String value = optionsController.text.trim();
    if (value.isNotEmpty) {
      setState(() {
        arrayFieldValues.add(value);
      });
      optionsController.clear();
    }
  }

  // Remove a value from the array field
  void removeArrayFieldValue(int index) {
    setState(() {
      arrayFieldValues.removeAt(index);
    });
  }

 
  void addData() {
    String question = questionController.text;
    // String correctAnswer = correctAnserController.text;
    

    _firestore.collection('quiz').add({
      'question': question,
      // 'correctAnswer': correctAnswer,
      // 'options': arrayFieldValues,
    }).then((value) {
      print('Data added successfully');
      questionController.clear();
      correctAnserController.clear();
      

      setState(() {
        optionsController.clear();
      });
    }).catchError((error) {
      print('Failed to add data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase CRUD Operations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: questionController,
            decoration: InputDecoration(
              labelText: 'Question',
            ),
          ),
        
          // TextField(
          //   controller: correctAnserController,
          //   decoration: InputDecoration(
          //     labelText: 'Currect Anser',
          //   ),
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextField(
          //         controller: optionsController,
          //         decoration: InputDecoration(
          //           labelText: 'Options Field',
          //         ),
          //       ),
          //     ),
          //     ElevatedButton(
          //       onPressed: addArrayFieldValue,
          //       child: Text('Add'),
          //     ),
          //   ],
          // ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: arrayFieldValues.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(arrayFieldValues[index]),
          //       trailing: IconButton(
          //         icon: Icon(Icons.delete),
          //         onPressed: () => removeArrayFieldValue(index),
          //       ),
          //     );
          //   },
          // ),
          ElevatedButton(
            onPressed: addData,
            child: Text('Add Data'),
          ),
        ],
      ),
    );
  }
}
