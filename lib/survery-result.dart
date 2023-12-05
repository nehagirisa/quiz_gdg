import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:quiz_gdg/widget/footer/footer.dart';
import 'package:velocity_x/velocity_x.dart';

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
       backgroundColor: Color.fromARGB(255, 238, 184, 47),
     
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const Text(
            "Mindfulness for Developers",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
           SizedBox(height: 10),
              Text('Total Score: $totalScore',
              style: TextStyle(
                fontSize:25, fontWeight: FontWeight.bold, color: Colors.white),),
              SizedBox(height: 15),
              
              Stack(
                children: [
                  
                   Image.asset(
                    'assets/logo1.png',
                    height:context.isMobile ? 300:400,
                    width: context.isMobile ? 300:400,
                    fit: BoxFit.cover,
                  ),
                     Positioned(
                      top:context.isMobile? 79: 105,
                      left:context.isMobile? 78:108,
                       child: Container(
                        width:context.isMobile ? 150:180,
                        height: context.isMobile ? 150:180,
                        child: LiquidCircularProgressIndicator(
                          value: percentage, // Pass the converted percentage value
                          backgroundColor: Colors.grey[300]!,
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                          borderColor: Colors.blue,
                          borderWidth: 4.0,
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
                     ),
                
                ],
              ),
                const SizedBox(height: 20),
              Text("Interpretation",
               style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),),
                 Text(' ${getResultInterpretation()}',
                  style: TextStyle(
                fontSize: 23,  color: Colors.white),),
                Spacer(),
                Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
