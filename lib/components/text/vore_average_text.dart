import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoteAverageText extends StatelessWidget {
  const VoteAverageText({
    Key key,
    this.text: '',
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
          color: Colors.amber, fontSize: 12, fontWeight: FontWeight.w700),
    );
  }
}
