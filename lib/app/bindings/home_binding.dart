import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:desafio_flutter/app/controllers/home_controller.dart';
import 'package:desafio_flutter/app/data/providers/api.dart';
import 'package:desafio_flutter/app/data/repository/movie_repository.dart';
import 'package:desafio_flutter/app/data/repository/genres_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(
        movieRepository:
            MovieRepository(apiClient: ApiClient(httpClient: http.Client())),
        genresRepository:
            GenresRepository(apiClient: ApiClient(httpClient: http.Client()))));
  }
}
