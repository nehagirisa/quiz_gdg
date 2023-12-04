import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class SurveyResultPage extends StatelessWidget {
  final int totalScore;

  SurveyResultPage({required this.totalScore});

  String getResultInterpretation() {
    if (totalScore >= 10 && totalScore <= 25) {
      return "Possible mental health concerns; seek professional help.";
    } else if (totalScore > 25 && totalScore <= 35) {
      return "Average mental health; consider exploring strategies to enhance well-being.";
    } else if (totalScore > 35 && totalScore <= 45) {
      return "Good mental health; continue practicing self-care and maintaining a healthy lifestyle.";
    } else {
      return "Excellent mental health; maintain healthy habits and seek support if needed.";
    }
  }

  @override
  Widget build(BuildContext context) {
    double percentage = totalScore / 100.0; // Assuming the maximum possible score is 100

    return Scaffold(
     
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Total Score: $totalScore'),
              SizedBox(height: 10),
              Text('Interpretation: ${getResultInterpretation()}'),
              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 200,
                child: LiquidCircularProgressIndicator(
                  value: percentage, // Pass the converted percentage value
                  backgroundColor: Colors.grey[300]!,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  borderColor: Colors.blue,
                  borderWidth: 5.0,
                  direction: Axis.vertical,
                  center: Text(
                    '${(percentage * 100).toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
