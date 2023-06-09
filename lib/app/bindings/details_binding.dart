import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:desafio_flutter/app/controllers/details_controller.dart';
import 'package:desafio_flutter/app/data/repository/details_repository.dart';
import 'package:desafio_flutter/app/data/providers/api.dart';

class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailsController(
        detailsRepository: DetailsRepository(
            apiClient: ApiClient(httpClient: http.Client()))));
  }
}
