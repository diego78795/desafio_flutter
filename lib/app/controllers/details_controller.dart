import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:desafio_flutter/app/data/model/details_model.dart';
import 'package:desafio_flutter/app/data/repository/details_repository.dart';

class DetailsController extends GetxController {
  final DetailsRepository? detailsRepository;
  DetailsController({@required this.detailsRepository})
      : assert(detailsRepository != null);
  bool isLoading = true;

  DetailsModel details = DetailsModel();
  int idMovie = Get.arguments["movie_id"];

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    details = await detailsRepository?.getDetailsMovie(idMovie);
    isLoading = false;
    update();
  }
}
