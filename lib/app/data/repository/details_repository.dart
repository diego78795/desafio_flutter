import 'package:desafio_flutter/app/data/providers/api.dart';
import 'package:flutter/material.dart';

class DetailsRepository {
  final ApiClient? apiClient;

  DetailsRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getDetailsMovie(int idMovie) {
    return apiClient!.apiDetailsMovie(idMovie);
  }
}
