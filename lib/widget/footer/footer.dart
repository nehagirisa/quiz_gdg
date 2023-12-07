import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});
 
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    return Container(
        height: screenHeight * 0.15,
        width: double.infinity,
        color: const Color.fromARGB(255, 248, 248, 248),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/gdg.png',
              height: context.isMobile ? 100: 150,
              width: context.isMobile ? 100: 150,
            ),
           
           SizedBox(height: screenHeight * 0.20,),
            Image.asset(
              'assets/microbiomeSuperhero.png',
              height: context.isMobile ? 150: 200,
              width: context.isMobile ? 150: 200,
            ),
          ],
        ));
  }
}