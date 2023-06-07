import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:desafio_flutter/app/routes/app_pages.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Desafio Flutter',
      initialRoute: Routes.HOME,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
