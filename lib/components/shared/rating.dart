import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  final double rating;
  final double size;

  const Rating({
    Key key,
    this.rating: 3,
    this.size: 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating / 2,
      itemCount: 5,
      itemPadding: EdgeInsets.only(right: 2.5),
      direction: Axis.horizontal,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: size,
    );
  }
}
