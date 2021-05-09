import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_movie/model/dto/now_playing_movie_data.dart';
import 'package:flutter_movie/model/dto/popular_movie_data.dart';
import 'package:flutter_movie/model/dto/top_rated_movie_data.dart';
import 'package:flutter_movie/model/dto/upcoming_movie_data.dart';
import 'package:flutter_movie/model/results.dart';
import 'package:http/http.dart' as http;

class MovieProvider with ChangeNotifier {
  String _selectedMovieId;
  List<Results> _nowPlayingList = [];
  int _nowPlayingPageKey = 1;
  int _nowPlayingPageSize;
  List<Results> _popularList = [];
  int _popularPageKey = 1;
  int _popularPageSize;
  List<Results> _topRatedList = [];
  int _topRatedPageKey = 1;
  int _topRatedPageSize;
  List<Results> _upcomingList = [];
  int _upcomingPageKey = 1;
  int _upcomingPageSize;

  //상영중 영화
  Future<void> getNowPlayingLists() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=${FlutterConfig.get('API_KEY')}&language=ko-KR&page=$_nowPlayingPageKey&region=KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    NowPlayingMovieData data = NowPlayingMovieData.fromJson(jsonData);
    final List<Results> list = data.results;
    if (nowPlayingPageKey == 1) {
      _nowPlayingList = list;
      _nowPlayingPageSize = data.totalPages;
    } else {
      _nowPlayingList..addAll(list);
    }
  }

  //개봉 예정 영화
  Future<void> getUpcomingLists() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=${FlutterConfig.get('API_KEY')}&language=ko-KR&page=$_upcomingPageKey&region=KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    UpcomingMovieData data = UpcomingMovieData.fromJson(jsonData);
    final List<Results> list = data.results;
    if (_upcomingPageKey == 1) {
      _upcomingList = list;
      _upcomingPageSize = data.totalPages;
    } else {
      _upcomingList..addAll(list);
    }
  }

  //인기 순위
  Future<void> getPopularList() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=${FlutterConfig.get('API_KEY')}&language=ko-KR&page=$_upcomingPageKey&region=KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    PopularMovieData data = PopularMovieData.fromJson(jsonData);
    final List<Results> list = data.results;
    if (_popularPageKey == 1) {
      _popularList = list;
      _popularPageSize = data.totalPages;
    } else if (_popularPageKey < _popularPageSize) {
      _popularList.addAll(list);
    }
  }

  //높은 평점 순위
  Future<void> getTopRatedList() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=${FlutterConfig.get('API_KEY')}&language=ko-KR&page=$_topRatedPageKey&region=KR');
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    TopRatedMovieData data = TopRatedMovieData.fromJson(jsonData);
    final List<Results> list = data.results;
    if (_topRatedPageKey == 1) {
      _topRatedList = list;
      _topRatedPageSize = data.totalPages;
    } else {
      _topRatedList.addAll(list);
    }
  }

  String get selectedMovieId => _selectedMovieId;

  set selectedMovieId(String value) {
    _selectedMovieId = value;
    notifyListeners();
  }

  List<Results> get upcomingList => _upcomingList;

  set upcomingList(List<Results> value) {
    _upcomingList = value;
    notifyListeners();
  }

  List<Results> get topRatedList => _topRatedList;

  set topRatedList(List<Results> value) {
    _topRatedList = value;
    notifyListeners();
  }

  List<Results> get popularList => _popularList;

  set popularList(List<Results> value) {
    _popularList = value;
    notifyListeners();
  }

  List<Results> get nowPlayingList => _nowPlayingList;

  set nowPlayingList(List<Results> value) {
    _nowPlayingList = value;
    notifyListeners();
  }

  int get upcomingPageKey => _upcomingPageKey;

  set upcomingPageKey(int value) {
    _upcomingPageKey = value;
    notifyListeners();
  }

  int get topRatedPageKey => _topRatedPageKey;

  set topRatedPageKey(int value) {
    _topRatedPageKey = value;
    notifyListeners();
  }

  int get popularPageKey => _popularPageKey;

  set popularPageKey(int value) {
    _popularPageKey = value;
    notifyListeners();
  }

  int get nowPlayingPageKey => _nowPlayingPageKey;

  set nowPlayingPageKey(int value) {
    _nowPlayingPageKey = value;
    notifyListeners();
  }

  int get upcomingPageSize => _upcomingPageSize;

  set upcomingPageSize(int value) {
    _upcomingPageSize = value;
    notifyListeners();
  }

  int get topRatedPageSize => _topRatedPageSize;

  set topRatedPageSize(int value) {
    _topRatedPageSize = value;
    notifyListeners();
  }

  int get popularPageSize => _popularPageSize;

  set popularPageSize(int value) {
    _popularPageSize = value;
    notifyListeners();
  }

  int get nowPlayingPageSize => _nowPlayingPageSize;

  set nowPlayingPageSize(int value) {
    _nowPlayingPageSize = value;
    notifyListeners();
  }
}
