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
    return RatingBar.builder(
      ignoreGestures: true,
      initialRating: rating,
      minRating: 0,
      itemCount: 5,
      itemPadding: EdgeInsets.only(right: 2.5),
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: size,
      onRatingUpdate: (rating) {},
    );
  }
}
