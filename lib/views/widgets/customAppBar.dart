import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(height: 50, 'images/wvbg.png'),
        RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(children: [
              TextSpan(
                  text: "Wallpaper",
                  style: TextStyle(
                      color: Color.fromARGB(255, 252, 252, 251),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico')),
              TextSpan(
                  text: " Valley",
                  style: TextStyle(
                      color: Color.fromARGB(255, 244, 243, 243),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico'))
            ])),
      ],
    );
  }
}
