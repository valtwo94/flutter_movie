import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final double size;

  const TitleText({
    Key key,
    this.title: '',
    this.size: 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: size,
      ),
    );
  }
}
