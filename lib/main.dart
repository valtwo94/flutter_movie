import 'package:flutter/material.dart';
import 'package:flutter_movie/screens/movie/detail_screen.dart';
import 'package:flutter_movie/screens/movie/list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '아테나스 랩 코딩테스트',
      debugShowCheckedModeBanner: false,
      home: MovieDetailScreen(),
      routes: {
        MovieListScreen.id: (context) => MovieListScreen(),
        MovieDetailScreen.id: (context) => MovieDetailScreen()
      },
    );
  }
}
