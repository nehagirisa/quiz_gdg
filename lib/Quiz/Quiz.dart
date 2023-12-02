
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_gdg/Quiz/Quiz_model.dart';
// import 'package:quiz_gdg/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  late List<Question> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  // Future<void> fetchQuestions() async {
  //   final QuerySnapshot snapshot =
  //       await FirebaseFirestore.instance.collection('quizzes').limit(10).get();

  //   setState(() {
  //      final List<Question> allQuestions = snapshot.docs.map((doc) {
  //       final List<String> options = List.from(doc['options'] as List);
  //       return Question(
  //         question: doc['question'].toString(),
  //         image: doc['image'].toString(),
  //         options: options,
  //         correctAnswerIndex: doc['correctAnswer'].toString(),
  //          questions = [allQuestions[randomIndex]];
  //       );
        
  //     }).toList();
  //   });
  // }
    Future<void> fetchQuestions() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('quizzes').limit(5).get();

    final List<Question> allQuestions = snapshot.docs.map((doc) {
      final List<String> options = List.from(doc['options'] as List);
      return Question(
        question: doc['question'].toString(),
        image: doc['image'].toString(),
        options: options,
        correctAnswerIndex: doc['correctAnswer'].toString(),
      );
    }).toList();

     final random = Random();
    final List<Question> randomQuestions = [];


     for (int i = 0; i < 5; i++) {
      final randomIndex = random.nextInt(allQuestions.length);
      randomQuestions.add(allQuestions[randomIndex]);
      allQuestions.removeAt(randomIndex);
    }

    setState(() {
    questions = randomQuestions;
    });
   }

  void answerQuestion(String selectedOption) {
    String correctAnswer = questions[currentQuestionIndex].correctAnswerIndex;
    if (selectedOption == correctAnswer) {
      setState(() {
        score++;
      });
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showResultDialog();
    }
  }

  void showResultDialog() {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Quiz Result',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ).centered(),
          content: Text('Your Quiz score: $score / ${questions.length}'),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                     setState(() {
                      currentQuestionIndex = 0;
                      score = 0;
                    });
                    Navigator.push(context,
                          // ignore: inference_failure_on_instance_creation
                          MaterialPageRoute(
                            builder: (_) =>QuizApp(),
                          ),);
                   
                  },
                  child: const Text('Restart Quiz'),
                ),
                // TextButton(
                //   onPressed: () {
                //      Navigator.push(
                //           context,
                //           // ignore: inference_failure_on_instance_creation
                //           MaterialPageRoute(
                //             builder: (_) =>DashboardScreen(),
                //           ),);
                //     setState(() {
                //       currentQuestionIndex = 0;
                //       score = 0;
                //     });
                //   },
                //   child: const Text('Go to Home'),
                // ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           iconTheme:const IconThemeData(color: Colors.white),
          backgroundColor: Colors.green, 
          centerTitle: true,
          title: Text('Quiz',
              style: GoogleFonts.chicle(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 30,
                    letterSpacing: 1.0),
              )),
        
        ),
      body: (questions.isNotEmpty)
          ? Container(
              //  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}/${questions.length.toString()}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ).centered(),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Column(
                        children: [
                          Image.network( 
                            questions[currentQuestionIndex].image,
                            width: context.screenWidth * 0.8,
                            height: context.screenHeight * 0.3,
                          fit: BoxFit.cover,),
                          const SizedBox(height: 5,),
                          Text(
                            questions[currentQuestionIndex].question,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ).centered(),
                          const SizedBox(height: 10.0),
                          ...questions[currentQuestionIndex]
                              .options
                              .map((option) {
                            return 
                          
                               ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                onPressed: () => answerQuestion(option),
                                child: Text(
                                  option,
                                  style: TextStyle(fontSize: 15),
                                ).p8(),
                              ).py8();
                            // );
                          }).toList()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const CircularProgressIndicator().centered(),
    );
  }
}
