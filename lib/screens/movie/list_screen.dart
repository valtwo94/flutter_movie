import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/components/list/movie_list.dart';
import 'package:flutter_movie/components/shared/rating.dart';
import 'package:flutter_movie/components/text/title_text.dart';
import 'package:flutter_movie/providers/movie_provider.dart';
import 'package:flutter_movie/screens/movie/detail_screen.dart';
import 'package:flutter_movie/utils/shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  static final String id = '/movie';

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  bool _isLoading = true;
  ScrollController _nowPlayingController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () async {
      var movieProvider = Provider.of<MovieProvider>(context, listen: false);
      await movieProvider.getNowPlayingLists();
      await movieProvider.getUpcomingLists();
      await movieProvider.getPopularList();
      await movieProvider.getTopRatedList();
      setState(() {
        _isLoading = false;
      });
      _nowPlayingController.addListener(() {
        if (_nowPlayingController.position.pixels ==
            _nowPlayingController.position.maxScrollExtent) {
          if (movieProvider.nowPlayingPageKey <
              movieProvider.nowPlayingPageSize) {
            movieProvider.nowPlayingPageKey++;
            print(movieProvider.nowPlayingPageKey);
            movieProvider.getNowPlayingLists();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _nowPlayingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: true);

    return Scaffold(
      body: _isLoading
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
                              controller: _nowPlayingController,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: movieProvider.nowPlayingList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    movieProvider.selectedMovieId =
                                        movieProvider.nowPlayingList[index].id
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
                                                          movieProvider
                                                              .nowPlayingList[
                                                                  index]
                                                              .posterPath))),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          movieProvider
                                              .nowPlayingList[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.notoSans(
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Rating(
                                          rating: movieProvider
                                              .nowPlayingList[index].voteAverage
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
                    results: movieProvider?.upcomingList,
                    title: '개봉 예정',
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //Section3 => 인기
                  MovieList(
                    results: movieProvider?.popularList,
                    title: '인기',
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //Section4 => 높은 평점
                  MovieList(
                    results: movieProvider?.topRatedList,
                    title: '높은 평점',
                  ),
                ],
              ),
            ),
    );
  }
}
