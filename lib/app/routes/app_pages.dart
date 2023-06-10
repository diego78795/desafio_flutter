import 'package:get/get.dart';

import 'package:desafio_flutter/app/ui/home/home_page.dart';
import 'package:desafio_flutter/app/ui/details/details_page.dart';

import 'package:desafio_flutter/app/bindings/home_binding.dart';
import 'package:desafio_flutter/app/bindings/details_binding.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.details,
        page: () => const DetailsPage(),
        binding: DetailsBinding())
  ];
}
