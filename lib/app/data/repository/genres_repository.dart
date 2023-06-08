import 'package:desafio_flutter/app/data/providers/api.dart';
import 'package:flutter/material.dart';

class GenresRepository {
  final ApiClient? apiClient;

  GenresRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getGenresList() {
    return apiClient!.apiGenresList();
  }
}
