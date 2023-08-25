import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DecorationText extends StatelessWidget {
  const DecorationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Empowerment through Awareness',
      style: GoogleFonts.actor(
        textStyle: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          
        ),
      ),
      textAlign: TextAlign.center,
    );
  }
}
