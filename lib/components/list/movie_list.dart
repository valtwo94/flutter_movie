import 'package:flutter/material.dart';
import 'package:flutter_movie/components/shared/rating.dart';
import 'package:flutter_movie/components/text/date_text.dart';
import 'package:flutter_movie/components/text/genre_text.dart';
import 'package:flutter_movie/components/text/title_text.dart';
import 'package:flutter_movie/utils/shadow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieList extends StatelessWidget {
  final String title;

  const MovieList({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(title: title),
          SizedBox(
            height: 16,
          ),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  height: 69,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 69,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: itemShadow),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '영화제목',
                            style: GoogleFonts.notoSans(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Rating(),
                          SizedBox(
                            height: 16.2,
                          ),
                          Container(
                            width: 288,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GenreText(
                                  text: '장르',
                                ),
                                DateText(),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
