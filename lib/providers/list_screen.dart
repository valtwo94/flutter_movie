import 'package:flutter/material.dart';

class ListScreenProvider with ChangeNotifier {
  String _selectedMovieId;

  String get selectedMovieId => _selectedMovieId;

  set selectedMovieId(String value) {
    _selectedMovieId = value;
    notifyListeners();
  }
}
