import 'package:flutter/material.dart';

import 'package:desafio_flutter/app/data/providers/api.dart';

class DetailsRepository {
  final ApiClient? apiClient;

  DetailsRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getDetailsMovie(int idMovie) {
    return apiClient!.apiDetailsMovie(idMovie);
  }

  Future getCreditsMovie(int idMovie) {
    return apiClient!.apiCreditsMovie(idMovie);
  }
}
