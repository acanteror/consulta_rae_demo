import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rae_test/extension/context_extension.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Consulta',
        style: GoogleFonts.varela(
          fontSize: context.pcw(9),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: 'R',
            style: GoogleFonts.varela(
              fontSize: context.pcw(10),
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: 'ae',
            style: GoogleFonts.varela(
              fontSize: context.pcw(9),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
