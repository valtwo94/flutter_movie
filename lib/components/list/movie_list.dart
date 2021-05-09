import 'package:flutter/material.dart';
import 'package:flutter_movie/components/shared/rating.dart';
import 'package:flutter_movie/components/text/date_text.dart';
import 'package:flutter_movie/components/text/genre_text.dart';
import 'package:flutter_movie/components/text/title_text.dart';
import 'package:flutter_movie/model/results.dart';
import 'package:flutter_movie/providers/movie_provider.dart';
import 'package:flutter_movie/screens/movie/detail_screen.dart';
import 'package:flutter_movie/utils/shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MovieList extends StatelessWidget {
  final String title;
  final int itemCount;
  final List<Results> results;

  const MovieList({
    Key key,
    @required this.title,
    this.itemCount: 3,
    this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: true);
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
                return GestureDetector(
                  onTap: () {
                    movieProvider.selectedMovieId =
                        results[index]?.id.toString();
                    Navigator.pushNamed(context, MovieDetailScreen.id);
                  },
                  child: Container(
                    height: 69,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 69,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: itemShadow,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500/' +
                                          results[index]?.posterPath))),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${results[index]?.title}',
                              style: GoogleFonts.notoSans(
                                  fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Rating(
                              rating: results[index].voteAverage.toDouble(),
                            ),
                            SizedBox(
                              height: 16.2,
                            ),
                            Container(
                              width: 288,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                  ),
                );
              })
        ],
      ),
    );
  }
}
