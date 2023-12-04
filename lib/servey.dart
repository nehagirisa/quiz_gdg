
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_gdg/survery-result.dart';

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
      appBar: AppBar(
        title: Text('Mental Health Survey'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return buildQuestionPage(index);
        },
      ),
    );
  }

  Widget buildQuestionPage(int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${index + 1}. ${questions[index]['question']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                for (int j = 1; j <= 5; j++)
                  Row(
                    children: [
                      Radio<int>(
                        value: j * 2,
                        groupValue: questionScores[index + 1],
                        onChanged: (int? value) {
                          setState(() {
                            questionScores[index + 1] = value!;
                          });
                        },
                      ),
                      Text(radioLabels[j - 1]),
                      SizedBox(width: 10),
                    ],
                  ),
              ],
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
          ],
        ),
      ),
    );
  }
}
