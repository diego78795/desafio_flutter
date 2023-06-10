import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:desafio_flutter/app/data/model/details_model.dart';
import 'package:desafio_flutter/app/data/model/credits_model.dart';
import 'package:desafio_flutter/app/data/repository/details_repository.dart';

class DetailsController extends GetxController {
  final DetailsRepository? detailsRepository;
  DetailsController({@required this.detailsRepository})
      : assert(detailsRepository != null);
  bool isLoading = true;

  DetailsModel details = DetailsModel();
  String director = "";
  String cast = "";

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading = true;
    details =
        await detailsRepository?.getDetailsMovie(Get.arguments["movie_id"]);
    CreditsModel credits =
        await detailsRepository?.getCreditsMovie(Get.arguments["movie_id"]);
    director = credits.crew
        .where((person) => person['job'] == 'Director')
        .map((director) => director['name'])
        .toString();
    director = director.substring(1, director.length - 1);
    for (Map<String, dynamic> actor in credits.cast) {
      cast = '$cast, ${actor['name']}';
    }
    cast = cast.substring(2);
    isLoading = false;
    update();
  }
}
