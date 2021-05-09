import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tag extends StatelessWidget {
  final String text;

  const Tag({
    Key key,
    this.text: '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 27,
      height: 12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            width: 1,
            color: Color.fromRGBO(246, 96, 96, 1),
          )),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.notoSans(
              color: Color.fromRGBO(246, 96, 96, 1),
              fontSize: 7,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
