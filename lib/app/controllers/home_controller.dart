import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:desafio_flutter/app/data/model/movie_model.dart';
import 'package:desafio_flutter/app/data/repository/movie_repository.dart';

class HomeController extends GetxController {
  final MovieRepository? movieRepository;
  HomeController({@required this.movieRepository})
      : assert(movieRepository != null);

  bool isLoading = true;
  List<MovieModel> movieList = [];

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    movieList = await getGenreMovies(28);
    isLoading = false;
    update();
  }

  Future<List<MovieModel>> getGenreMovies(int idGenre) async {
    return await movieRepository?.getGenreMovies(idGenre);
  }
}
