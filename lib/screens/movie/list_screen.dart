import 'package:flutter/material.dart';
import 'package:flutter_movie/components/list/movie_list.dart';
import 'package:flutter_movie/components/shared/rating.dart';
import 'package:flutter_movie/components/text/title_text.dart';
import 'package:flutter_movie/utils/shadow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieListScreen extends StatelessWidget {
  static final String id = '/movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 43),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Section1 => 현재 상영중
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    title: '현재 상영중',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 252,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 104,
                            margin: EdgeInsets.only(right: 17),
                            child: Column(
                              children: [
                                Container(
                                  width: 104,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: itemShadow),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '영화 제목',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.notoSans(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Rating(
                                  size: 10,
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            //Section2 => 개봉 예정
            MovieList(
              title: '개봉 예정',
            ),
            SizedBox(
              height: 24,
            ),
            //Section3 => 인기
            MovieList(
              title: '인기',
            ),
            SizedBox(
              height: 24,
            ),
            //Section4 => 높은 평점
            MovieList(
              title: '높은 평점',
            ),
          ],
        ),
      ),
    );
  }
}
