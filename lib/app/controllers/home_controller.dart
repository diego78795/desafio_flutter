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

  final _genreSelected = GenresModel().obs;
  get genreSelected => _genreSelected.value;
  set genreSelected(value) => _genreSelected.value = value;

  final _searchText = ''.obs;
  get searchText => _searchText.value;
  set searchText(value) => _searchText.value = value;

  final _pagination = 1.obs;
  get pagination => _pagination.value;
  set pagination(value) => _pagination.value = value;

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
    genreSelected = genre;
    movieList = await movieRepository?.getGenreMovies(genre.id, pagination);
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

  Future searchMovie() async {
    movieList = await movieRepository?.getSearchMovies(
        searchText.replaceAll(" ", "%20"), pagination);
    if (genreSelected.id != 0) {
      movieList = movieList
          .where((movie) => movie.genres.contains(genreSelected.id))
          .toList();
    }
  }

  Future handleSearchMovie() async {
    isLoading = true;
    update();
    pagination = 1;
    await searchMovie();
    isLoading = false;
    update();
  }

  Future handleGenreMovie(GenresModel genre) async {
    isLoading = true;
    update();
    pagination = 1;
    await getGenreMovies(genre);
    isLoading = false;
    update();
  }

  Future handleRemoveGenreMovie() async {
    isLoading = true;
    update();
    movieList = await movieRepository?.getTrending();
    genreSelected = GenresModel();
    isLoading = false;
    update();
  }

  Future handlePagination(int pagesNumber) async {
    isLoading = true;
    update();
    pagination += pagesNumber;
    if (searchText == '') {
      await getGenreMovies(genreSelected);
    } else {
      await searchMovie();
    }
    if (movieList.isEmpty) {
      pagination -= pagesNumber;
      if (searchText == '') {
        await getGenreMovies(genreSelected);
      } else {
        await searchMovie();
      }
    }
    isLoading = false;
    update();
  }
}
