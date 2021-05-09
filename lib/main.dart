import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/providers/movie_provider.dart';
import 'package:flutter_movie/screens/movie/detail_screen.dart';
import 'package:flutter_movie/screens/movie/list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: MovieProvider())],
      child: MaterialApp(
        title: '코딩테스트',
        debugShowCheckedModeBanner: false,
        home: MovieListScreen(),
        routes: {
          MovieListScreen.id: (context) => MovieListScreen(),
          MovieDetailScreen.id: (context) => MovieDetailScreen()
        },
      ),
    );
  }
}
