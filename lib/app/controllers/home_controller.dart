import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:desafio_flutter/app/data/model/movie_model.dart';
import 'package:desafio_flutter/app/data/model/genres_model.dart';

import 'package:desafio_flutter/app/data/repository/movie_repository.dart';
import 'package:desafio_flutter/app/data/repository/genres_repository.dart';

class HomeController extends GetxController {
  final MovieRepository? movieRepository;
  final GenresRepository? genresRepository;
  HomeController(
      {@required this.movieRepository, @required this.genresRepository})
      : assert(movieRepository != null, genresRepository != null);

  bool isLoading = true;
  List<MovieModel> movieList = [];
  List<GenresModel> genresList = [];

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    genresList = await genresRepository?.getGenresList();
    movieList = await movieRepository?.getGenreMovies(genresList[0].id);
    isLoading = false;
    update();
  }

  Future<List<MovieModel>> getGenreMovies(int idGenre) async {
    return await movieRepository?.getGenreMovies(idGenre);
  }
}
