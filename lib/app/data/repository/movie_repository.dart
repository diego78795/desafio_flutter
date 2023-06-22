import 'package:desafio_flutter/app/data/providers/api.dart';
import 'package:flutter/material.dart';

class MovieRepository {
  final ApiClient? apiClient;

  MovieRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getTrending() {
    return apiClient!.apiTrending();
  }

  Future getGenreMovies(int idGenre, int page) {
    return apiClient!.apiGenreMovies(idGenre, page);
  }

  Future getSearchMovies(String searchText, int page) {
    return apiClient!.apiSearchMovies(searchText, page);
  }
}
