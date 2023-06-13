import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DecorationText extends StatelessWidget {
  const DecorationText({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(
      'Empowerment through Awareness',
      style: GoogleFonts.actor(
        textStyle: TextStyle(
          fontSize: width / 60,
          fontWeight: FontWeight.bold,
          
        ),
      ),
      textAlign: TextAlign.center,
    );
  }
}
