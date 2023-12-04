import 'package:flutter/material.dart';
import 'package:quiz_gdg/survery-result.dart';


class MentalHealthSurveyForm extends StatefulWidget {
  @override
  _MentalHealthSurveyFormState createState() => _MentalHealthSurveyFormState();
}

class _MentalHealthSurveyFormState extends State<MentalHealthSurveyForm> {
  Map<int, int> questionScores = {};
   List<String> radioLabels = [
    'Strongly Disagree',
    'Disagree',
    'Neutral',
    'Agree',
    'Strongly Agree',
  ];
  
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 1; i <= 10; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          '$i. ${getQuestion(i)}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                       Row(
                      children: [
                        
                        for (int j = 1; j <= 5; j++)

                          Row(
                              children: [
                                Radio<int>(
                                  value: j * 2,
                                  groupValue: questionScores[i + 1],
                                  onChanged: (int? value) {
                                    setState(() {
                                      questionScores[i + 1] = value!;
                                    });
                                  },
                                ),
                                Text(radioLabels[j-1]),
                                SizedBox(width: 10),
                              ],
                            ),
                        SizedBox(width: 10),
                        // Text(' $i'),
                      ],
                    ),
                   
                    ],
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  submitSurvey();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getQuestion(int questionNumber) {
    switch (questionNumber) {
      case 1:
        return 'I generally feel happy and content.';
      case 2:
        return 'I feel motivated and energized to pursue my goals.';
      case 3:
        return 'I am able to handle stress and bounce back from setbacks.';
      case 4:
        return 'I have a support system of friends and/or family that I can rely on.';
      case 5:
        return 'I feel confident in my abilities and decisions.';
      case 6:
        return 'I experience a sense of purpose and meaning in my life.';
      case 7:
        return 'I am able to manage my emotions and regulate them effectively.';
      case 8:
        return 'I have healthy coping mechanisms to deal with challenges.';
      case 9:
        return 'I get sufficient sleep and feel well-rested.';
      case 10:
        return 'I engage in activities that bring me joy and relaxation.';
      default:
        return '';
    }
  }
}
