
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_gdg/survey-result.dart';
import 'package:quiz_gdg/surveyresult.dart';
import 'package:quiz_gdg/widget/footer/footer.dart';
import 'package:velocity_x/velocity_x.dart';

class MicrobiomeSurvey extends StatefulWidget {
  @override
  _MicrobiomeSurveyState createState() => _MicrobiomeSurveyState();
}

class _MicrobiomeSurveyState extends State<MicrobiomeSurvey> {
  PageController _pageController = PageController();
  Map<int, int> questionScores = {};
  List<Map<String, dynamic>> questions = [];

  final User? user = FirebaseAuth.instance.currentUser;
  Map<int, bool> isOptionSelectedMap = {};

  @override
  void initState() {
    super.initState();
    // Fetch questions from Firestore on initialization
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('quiz').get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          questions = querySnapshot.docs
              .map((doc) => doc.data())
              .toList()
              .cast<Map<String, dynamic>>();
        });
      }
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  void submitSurvey() {
    int totalScore = questionScores.values.reduce((a, b) => a + b);
    // Store the score in Firestore
    storeScoreInFirestore(totalScore);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => surveyresult(totalScore: totalScore),
      ),
    );
  }

  void storeScoreInFirestore(int totalScore) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
            'score': totalScore,
            // Add more fields if needed
          })
          .then((value) => print('Score updated successfully'))
          .catchError((error) => print('Failed to update score: $error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 238, 184, 47),
      backgroundColor: Color.fromARGB(243, 249, 200, 54),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Center(child: buildQuestionPage(index));
        },
      ),
    );
  }

  Widget buildQuestionPage(int index) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/superhero.png',
            height: context.isMobile ? 170 : 200,
            width: context.isMobile ? 150 : 200,
            fit: BoxFit.contain,
          ).centered(),
          SizedBox(height: screenHeight * 0.06),
          Container(
            height: screenHeight * 0.20,
            width: screenWidth * 0.90,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              '${index + 1}. ${questions[index]['question']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ).p8().centered(),
          ),

          SizedBox(height: 5),
          Container(
            width: context.isMobile ? 400 : 500,
            child: Column(
              children: [
                // for (int j = 1; j <= 5; j++)
                Row(
                  children: [
                    Radio<int>(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.white.withOpacity(.32);
                          }
                          return Colors.white;
                        },
                      ),
                      value: 4, // 4 for Yes
                      groupValue: questionScores[index + 1],
                      onChanged: (int? value) {
                        setState(() {
                          questionScores[index + 1] = value!;
                          isOptionSelectedMap[index] = true;

                          // Move to the next question
                          if (index < questions.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 1100),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            // If it's the last question, show the "Submit" button
                            // No need to automatically move to the next question
                          }
                        });
                      },
                    ),
                    const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 20,
                        // color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ).pOnly(left: 16, top: 2),
                //here is a logic for 25 question and get answer for score out of 100
                Row(
                  children: [
                    Radio<int>(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.white.withOpacity(.32);
                          }
                          return Colors.white;
                        },
                      ),
                      value: 2, // 2 for No
                      groupValue: questionScores[index + 1],
                      onChanged: (int? value) {
                        setState(() {
                          questionScores[index + 1] = value!;
                          isOptionSelectedMap[index] = true;

                          // Move to the next question
                          if (index < questions.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 1100),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            // If it's the last question, show the "Submit" button
                            // No need to automatically move to the next question
                          }
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 20,
                        //  color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ).pOnly(left: 16),
              ],
            ),
          ),
          // Show the "Submit" button only on the last question
          if (index == questions.length - 1)
            ElevatedButton(
              onPressed: isOptionSelectedMap[index] == true
                  ? () {
                      // Submit the survey
                      submitSurvey();
                    }
                  : null,
              child: Text('Submit').pOnly(top: 5),
            ).p2(),
          const Spacer(),
          Footer(),
        ],
      ),
    );
  }
}



//  Row(
//                   children: [
//                     Radio<int>(
//                       fillColor: MaterialStateProperty.resolveWith<Color>(
//                         (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.disabled)) {
//                             return Colors.white.withOpacity(.32);
//                           }
//                           return Colors.white;
//                         },
//                       ),
//                       value: 4, // 4 for Yes
//                       groupValue: questionScores[index + 1],
//                       onChanged: (int? value) {
//                         setState(() {
//                           questionScores[index + 1] = value!;
//                           isOptionSelectedMap[index] = true;
//                         });
//                       },
//                     ),
//                     const Text(
//                       'Yes',
//                       style: TextStyle(
//                         fontSize: 20,
//                         // color: Colors.white,
//                         fontWeight: FontWeight.w600
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                   ],
//                 ).pOnly(left: 16,top: 2),
//                 //here is a logic for 25 question and get answer for score out of 100
//                 Row(
//                   children: [
//                     Radio<int>(
//                       fillColor: MaterialStateProperty.resolveWith<Color>(
//                         (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.disabled)) {
//                             return Colors.white.withOpacity(.32);
//                           }
//                           return Colors.white;
//                         },
//                       ),
//                       value: 2, // 2 for No
//                       groupValue: questionScores[index + 1],
//                       onChanged: (int? value) {
//                         setState(() {
//                           questionScores[index + 1] = value!;
//                           isOptionSelectedMap[index] = true;
//                         });
//                       },
//                     ),
//                     const Text(
//                       'No',
//                       style: TextStyle(
//                         fontSize: 20,
//                         //  color: Colors.white,
//                         fontWeight: FontWeight.w600
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                   ],
//                 ).pOnly(left: 16),
//               ],
//             ),
//           ),
//           //  SizedBox(height: screenHeight * 0.05),
//           SizedBox(height: context.isMobile ? 25 : 30),
//           ElevatedButton(
//             onPressed: isOptionSelectedMap[index] == true
//                 ? () {
//                     // Move to the next question only if an option is selected
//                     if (index < questions.length - 1) {
//                       _pageController.nextPage(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                     } else {
//                       // If it's the last question, submit the survey
//                       submitSurvey();
//                     }
//                   }
//                 : null,
//             child: Text(index == questions.length - 1 ? 'Submit' : 'Next'),