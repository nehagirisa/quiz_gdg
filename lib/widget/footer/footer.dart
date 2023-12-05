import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: double.infinity,
        color: const Color.fromARGB(255, 248, 248, 248),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/gdg.png',
              height: 150,
              width: 150,
            ),
            30.widthBox,
            Image.asset(
              'assets/microbiomeSuperhero.png',
              height: 200,
              width: 200,
            ),
          ],
        ));
  }
}