import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/components/list/movie_list.dart';
import 'package:flutter_movie/components/shared/rating.dart';
import 'package:flutter_movie/components/text/title_text.dart';
import 'package:flutter_movie/model/dto/now_playing_movie_data.dart';
import 'package:flutter_movie/model/dto/popular_movie_data.dart';
import 'package:flutter_movie/model/dto/top_rated_movie_data.dart';
import 'package:flutter_movie/model/dto/upcoming_movie_data.dart';
import 'package:flutter_movie/providers/list_screen.dart';
import 'package:flutter_movie/screens/movie/detail_screen.dart';
import 'package:flutter_movie/utils/shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  static final String id = '/movie';

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  NowPlayingMovieData _nowPlayingMovieData;
  UpcomingMovieData _upcomingMovieData;
  PopularMovieData _popularMovieData;
  TopRatedMovieData _topRatedMovieData;
  bool isLoading = true;

  Future<void> getNowPlayingLists() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=6253d9838a1066479c2287df95aeb78e&language=ko-KR&page=1&region=KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    NowPlayingMovieData data = NowPlayingMovieData.fromJson(jsonData);
    setState(() {
      _nowPlayingMovieData = data;
    });
  }

  Future<void> getUpcomingLists() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=6253d9838a1066479c2287df95aeb78e&language=ko-KR&page=1&region=KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    UpcomingMovieData data = UpcomingMovieData.fromJson(jsonData);
    setState(() {
      _upcomingMovieData = data;
    });
  }

  Future<void> getPopularList() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=6253d9838a1066479c2287df95aeb78e&language=ko-KR&page=1&region=KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    PopularMovieData data = PopularMovieData.fromJson(jsonData);
    setState(() {
      _popularMovieData = data;
    });
  }

  Future<void> getTopRatedList() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=6253d9838a1066479c2287df95aeb78e&language=ko-KR&page=1&region=KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    TopRatedMovieData data = TopRatedMovieData.fromJson(jsonData);
    setState(() {
      _topRatedMovieData = data;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await getNowPlayingLists();
      await getUpcomingLists();
      await getPopularList();
      await getTopRatedList();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final listScreenProvider =
        Provider.of<ListScreenProvider>(context, listen: true);
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                              itemCount: _nowPlayingMovieData.results.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    listScreenProvider.selectedMovieId =
                                        _nowPlayingMovieData.results[index].id
                                            .toString();
                                    Navigator.pushNamed(
                                        context, MovieDetailScreen.id);
                                  },
                                  child: Container(
                                    width: 104,
                                    margin: EdgeInsets.only(right: 17),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 104,
                                          height: 160,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: itemShadow,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://image.tmdb.org/t/p/w500/' +
                                                          _nowPlayingMovieData
                                                              .results[index]
                                                              .posterPath))),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          _nowPlayingMovieData
                                              .results[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.notoSans(
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Rating(
                                          rating: _nowPlayingMovieData
                                              .results[index].voteAverage
                                              .toDouble(),
                                          size: 10,
                                        )
                                      ],
                                    ),
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
                    results: _upcomingMovieData.results,
                    title: '개봉 예정',
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //Section3 => 인기
                  MovieList(
                    results: _popularMovieData.results,
                    title: '인기',
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //Section4 => 높은 평점
                  MovieList(
                    results: _topRatedMovieData.results,
                    title: '높은 평점',
                  ),
                ],
              ),
            ),
    );
  }
}
