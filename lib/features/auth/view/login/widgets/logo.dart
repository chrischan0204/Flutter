import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.health_and_safety_sharp,
          size: 44,
          color: Colors.amberAccent,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Safety ETA',
          style: GoogleFonts.alumniSans(
            textStyle: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
