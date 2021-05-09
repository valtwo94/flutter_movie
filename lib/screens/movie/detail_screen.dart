import 'package:flutter/material.dart';
import 'package:flutter_movie/components/list/movie_list.dart';
import 'package:flutter_movie/components/shared/rating.dart';
import 'package:flutter_movie/components/shared/tag.dart';
import 'package:flutter_movie/components/text/Genre_text.dart';
import 'package:flutter_movie/components/text/date_text.dart';
import 'package:flutter_movie/components/text/title_text.dart';
import 'package:flutter_movie/utils/dummy.dart';
import 'package:flutter_movie/utils/shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetailScreen extends StatelessWidget {
  static final String id = '/movie/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 297,
              decoration: BoxDecoration(color: Colors.grey),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 169,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              padding:
                  EdgeInsets.only(top: 132, left: 16, right: 16, bottom: 76),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    title: '개요',
                    size: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text(
                      dummyDescription,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(130, 130, 130, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  // 주요 출연진
                  TitleText(
                    title: '주요 출연진',
                    size: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 80,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 16),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '출연진 이름',
                                  style: GoogleFonts.notoSans(
                                      fontSize: 8, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //리뷰
                  TitleText(
                    title: '리뷰',
                    size: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 3,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 16,
                        childAspectRatio: 288 / 71,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          margin:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 4)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dummyReview,
                                style: GoogleFonts.notoSans(
                                  height: 1.7,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(97, 97, 97, 1),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '유저이름',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Color.fromRGBO(161, 161, 161, 1),
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
            ),

            //이미지 + 영화 상세 인포
            Positioned(
              top: 118,
              left: 16,
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 104,
                      height: 159,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: itemShadow,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TitleText(
                          title: '미드나이트 스카이',
                          size: 12,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Tag(
                          text: 'Adult',
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        GenreText(
                          text: '드라마, SF',
                          size: 11,
                        ),
                        DateText(
                          text: '2020-12-10 발매',
                          size: 11,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Rating(
                          size: 15,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
