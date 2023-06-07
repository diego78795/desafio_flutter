import 'package:desafio_flutter/app/bindings/home_binding.dart';
import 'package:desafio_flutter/app/ui/home/home_page.dart';
import 'package:get/get.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME, page: () => const HomePage(), binding: HomeBinding())
  ];
}
