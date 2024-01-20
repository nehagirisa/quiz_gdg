
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_gdg/survey-result.dart';
import 'package:quiz_gdg/widget/footer/footer.dart';
import 'package:velocity_x/velocity_x.dart';

class MentalHealth extends StatefulWidget {
  @override
  _MentalHealthState createState() => _MentalHealthState();
}

class _MentalHealthState extends State<MentalHealth> {

  PageController _pageController = PageController();
  Map<int, int> questionScores = {};
  List<Map<String, dynamic>> questions = [];
  List<String> radioLabels = [
    'Strongly Disagree',
    'Disagree',
    'Neutral',
    'Agree',
    'Strongly Agree',
  ];
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
          await FirebaseFirestore.instance.collection('questions').get();

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
        builder: (context) => SurveyResultPage(totalScore: totalScore),
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
      backgroundColor: Color.fromARGB(255, 238, 184, 47),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo1.png',
              // height: context.isMobile ? 150:200,
              height: screenHeight * 0.25,
              width: context.isMobile ?150:200,
              fit: BoxFit.cover,
            ).centered(),
           SizedBox(height: screenHeight * 0.06),
            Text(
              '${index + 1}. ${questions[index]['question']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                width: context.isMobile ? 400 : 500,
                child: Column(
                  children: [
                    for (int j = 1; j <= 5; j++)
                      Row(
                        children: [
                          Radio<int>(
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.blue.withOpacity(.32);
                                }
                                return Colors.blue;
                              },
                            ),
                            value: j * 2,
                            groupValue: questionScores[index + 1],
                            onChanged: (int? value) {
                              setState(() {
                                questionScores[index + 1] = value!;
                                isOptionSelectedMap[index] = true;
                              });
                            },
                          ),
                          Text(
                            radioLabels[j - 1],
                            style: const TextStyle(
                              fontSize: 18, // Set font size
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            //  SizedBox(height: screenHeight * 0.05),
              SizedBox(height:context.isMobile? 25 :30),
            ElevatedButton(
              onPressed: isOptionSelectedMap[index] == true
                  ? () {
                      // Move to the next question only if an option is selected
                      if (index < questions.length - 1) {
                        _pageController.nextPage(
                          duration:const  Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // If it's the last question, submit the survey
                        submitSurvey();
                      }
                    }
                  : null,
              child: Text(index == questions.length - 1 ? 'Submit' : 'Next'),
            ).p2(),
    
        
             const Spacer(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
