import 'package:desafio_flutter/app/data/providers/api.dart';
import 'package:flutter/material.dart';

class MovieRepository {
  final ApiClient? apiClient;

  MovieRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getGenreMovies(int idGenre) {
    return apiClient!.apiGenreMovies(idGenre);
  }
}
