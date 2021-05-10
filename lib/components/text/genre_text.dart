import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreText extends StatelessWidget {
  final String text;
  final double size;

  const GenreText({
    Key key,
    this.text: '',
    this.size: 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: Text(
        text,
        style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w400,
            fontSize: size,
            color: Color.fromRGBO(154, 154, 154, 1)),
      ),
    );
  }
}
