import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_gdg/survery-result.dart';
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SurveyResultPage(totalScore: totalScore),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 184, 47),
      // appBar: AppBar(
      //  // automaticallyImplyLeading: false,
      //   title: Text('Mental Health Survey'),
      // ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Center(child: buildQuestionPage(index));
        },
      ),
    );
  }

  Widget buildQuestionPage(int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo1.png',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ).centered(),
          50.heightBox,
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
                          }),
                          value: j * 2,
                          groupValue: questionScores[index + 1],
                          onChanged: (int? value) {
                            setState(() {
                              questionScores[index + 1] = value!;
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
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Move to the next question
              if (index < questions.length - 1) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                // If it's the last question, submit the survey
                submitSurvey();
              }
            },
            child: Text(index == questions.length - 1 ? 'Submit' : 'Next'),
          ),
          Spacer(),
          Footer(),
        ],
      ),
    );
  }
}
