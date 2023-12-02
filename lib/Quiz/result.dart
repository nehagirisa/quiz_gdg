

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultPage({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Result',
          style: GoogleFonts.chicle(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 30,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Quiz Score: $score / $totalQuestions',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          Container(
            width: 200,
            height: 200,
            child:    LiquidCircularProgressIndicator(
              value:score / totalQuestions,
              backgroundColor: Colors.grey[300]!,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              borderColor: Colors.blue,
              borderWidth: 5.0,
              direction: Axis.vertical,
              center: Text(
                '${((score / totalQuestions) * 100).toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}
