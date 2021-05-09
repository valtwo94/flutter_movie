import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateText extends StatelessWidget {
  final String text;
  final double size;
  const DateText({
    Key key,
    this.text: '2021-12-12',
    this.size: 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
          fontWeight: FontWeight.w400,
          fontSize: size,
          color: Color.fromRGBO(154, 154, 154, 1)),
    );
  }
}
