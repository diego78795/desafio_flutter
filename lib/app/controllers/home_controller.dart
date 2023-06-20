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

  final _genreSelected = "".obs;
  get genreSelected => _genreSelected.value;
  set genreSelected(value) => _genreSelected.value = value;

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
    movieList = await movieRepository?.getTrending();
    isLoading = false;
    update();
  }

  Future getGenreMovies(GenresModel genre) async {
    genreSelected = genre.name;
    movieList = await movieRepository?.getGenreMovies(genre.id);
  }

  String genreMovie(List genres) {
    String genresName = genres
        .map((genre) => genresList
            .firstWhere((genreList) => genreList.id == genre,
                orElse: () => GenresModel())
            .name)
        .toString();
    return genresName.substring(1, genresName.length - 1).replaceAll(",", " -");
  }

  Future searchMovie(String searchText) async {
    isLoading = true;
    update();
    movieList = await movieRepository
        ?.getSearchMovies(searchText.replaceAll(" ", "%20"));
    isLoading = false;
    update();
  }

  Future handleGenreMovie(GenresModel genre) async {
    isLoading = true;
    update();
    await getGenreMovies(genre);
    isLoading = false;
    update();
  }
}
