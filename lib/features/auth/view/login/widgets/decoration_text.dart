import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DecorationText extends StatelessWidget {
  const DecorationText({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(
      'Welcome to Safety',
      style: GoogleFonts.amiko(
        textStyle: TextStyle(
          fontSize: width / 60,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
