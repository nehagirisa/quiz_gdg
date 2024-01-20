import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:velocity_x/velocity_x.dart';
class surveyresult extends StatefulWidget {
  final int totalScore;
  const surveyresult({Key? key, required this.totalScore}) : super(key: key);

  @override
  State<surveyresult> createState() => _surveyresultState();
}

class _surveyresultState extends State<surveyresult> {

  @override
  Widget build(BuildContext context) {
    double roundedTotalScore = (widget.totalScore / 20).roundToDouble() * 20;
    double percentage = roundedTotalScore / 20;
    double emojiRating = percentage;

    var screenSize = MediaQuery.of(context).size;
    

    return Scaffold(
      backgroundColor: Color.fromARGB(243, 249, 200, 54),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/superhero.png',
             height: context.isMobile ? 170:200,
            width: context.isMobile ? 150 : 200,
            fit: BoxFit.contain,
          ).centered(),
          const SizedBox(
            height: 20,
          ),
        Text('Total Score: ${widget.totalScore}',
              style: TextStyle(
                fontSize:25, fontWeight: FontWeight.bold, color: Colors.white),).centered(),
        const SizedBox(height: 25,),
          RatingBar.builder(
            initialRating: percentage,
            minRating: 1,
            allowHalfRating: true,
            unratedColor: Colors.grey,
            itemCount: 5,
            itemSize: 70.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            updateOnDrag: true,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                return 
                   Icon(
                     Icons.sentiment_very_dissatisfied,
                   
                    color: emojiRating == 1 ? Colors.red : Colors.grey,
                  );
                case 1:
                  return 
                  
                  Icon(
                    Icons.sentiment_dissatisfied,
                    color: emojiRating == 2 ? Colors.redAccent : Colors.grey,
                  );
                case 2:
                  return Icon(
                    Icons.sentiment_neutral,
                    color: emojiRating == 3 ? Colors.orange : Colors.grey,
                  );
                case 3:
                  return Icon(
                    Icons.sentiment_satisfied,
                    color: emojiRating == 4 ? Colors.lightGreen : Colors.grey,
                  );
                case 4:
                  return Icon(
                    Icons.sentiment_very_satisfied,
                    color: emojiRating == 5 ? Colors.green : Colors.grey,
                  );
                default:
                  return Container();
              }
            },
            onRatingUpdate: (ratingvalue) {
              setState(() {
                emojiRating = ratingvalue;
              });
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            emojiRating == 1
                ? "Just a few tiny friends in your tummy!"
      
                : emojiRating == 2
                    ? "A few more bunch of cool microbes joining the party inside you"
                    : emojiRating == 3
                        ? "Meet a bunch of cool microbes having a dance-off in your belly!"
                        : emojiRating == 4
                            ? "Your tummy is like a bustling city of happy microbe citizens."
                            : emojiRating == 5
                                ? "Your tummy's super cool with a diverse and joyful microbe community!"
                                : "",
            style: const TextStyle(
             fontSize:25, fontWeight: FontWeight.bold, color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        
        ],
      ),
    );
  }
}
