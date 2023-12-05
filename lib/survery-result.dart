import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:quiz_gdg/widget/footer/footer.dart';
import 'package:velocity_x/velocity_x.dart';

class SurveyResultPage extends StatefulWidget {
  final int totalScore;


  SurveyResultPage({required this.totalScore, });

  @override
  State<SurveyResultPage> createState() => _SurveyResultPageState();
}

class _SurveyResultPageState extends State<SurveyResultPage> {
  String getResultInterpretation() {
    if (widget.totalScore >= 10 && widget.totalScore <= 25) {
      return "Possible mental health concerns; seek professional help.";
    } else if (widget.totalScore > 25 && widget.totalScore <= 35) {
      return "Average mental health; consider exploring strategies to enhance well-being.";
    } else if (widget.totalScore > 35 && widget.totalScore <= 45) {
      return "Good mental health; continue practicing self-care and maintaining a healthy lifestyle.";
    } else {
      return "Excellent mental health; maintain healthy habits and seek support if needed.";
    }
  }


  @override
  Widget build(BuildContext context) {
    double percentage = widget.totalScore / 100.0; // Assuming the maximum possible score is 100

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
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
           SizedBox(height: 10),
              Text('Total Score: ${widget.totalScore}',
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
