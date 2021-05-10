import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_movie/components/shared/rating.dart';
import 'package:flutter_movie/components/shared/tag.dart';
import 'package:flutter_movie/components/text/Genre_text.dart';
import 'package:flutter_movie/components/text/date_text.dart';
import 'package:flutter_movie/components/text/title_text.dart';
import 'package:flutter_movie/components/text/vore_average_text.dart';
import 'package:flutter_movie/model/dto/id_movie_data.dart';
import 'package:flutter_movie/model/dto/movie_reviews_data.dart';
import 'package:flutter_movie/providers/movie_provider.dart';
import 'package:flutter_movie/utils/dummy.dart';
import 'package:flutter_movie/utils/shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MovieDetailScreen extends StatefulWidget {
  static final String id = '/movie/detail';

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  IdMovieData selectedMovie;
  MovieReviewsData movieReviewsData;
  var reviews;
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final selectedMovieId =
          Provider.of<MovieProvider>(context, listen: false).selectedMovieId;
      await getMovieById(selectedMovieId);
      await getReviewsById(selectedMovieId);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> getMovieById(String id) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=${FlutterConfig.get('API_KEY')}&language=ko-KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    IdMovieData data = IdMovieData.fromJson(jsonData);
    setState(() {
      selectedMovie = data;
    });
  }

  Future<void> getReviewsById(String id) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/reviews?api_key=${FlutterConfig.get('API_KEY')}&language=ko-KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    MovieReviewsData data = MovieReviewsData.fromJson(jsonData);
    print(data.results);
    setState(() {
      movieReviewsData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.darken),
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500/' +
                                    selectedMovie.backdropPath),
                            fit: BoxFit.cover)),
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
                    padding: EdgeInsets.only(
                        top: 132, left: 16, right: 16, bottom: 76),
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
                            '${selectedMovie.overview}',
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
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400),
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
                            itemCount: movieReviewsData.results.length,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 16,
                              childAspectRatio: 288 / 71,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          blurRadius: 4)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${movieReviewsData.results[index].content}',
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
                                          '${movieReviewsData.results[index].author}',
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            color: Color.fromRGBO(
                                                161, 161, 161, 1),
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
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500/' +
                                            selectedMovie.posterPath))),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TitleText(
                                title: '${selectedMovie.title}',
                                size: 12,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              selectedMovie.adult == true
                                  ? Tag(
                                      text: 'Adult',
                                    )
                                  : Container(),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: selectedMovie.genres
                                    .map<Widget>((genre) => GenreText(
                                          text: '${genre.name}',
                                          size: 11,
                                        ))
                                    .toList(),
                              ),
                              DateText(
                                text: '${selectedMovie.releaseDate} 발매',
                                size: 11,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Rating(
                                    rating: selectedMovie.voteAverage,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  VoteAverageText(
                                      text: '${selectedMovie.voteAverage}')
                                ],
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
