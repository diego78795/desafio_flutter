import 'package:desafio_flutter/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

    body: SafeArea(
      child: Text('Home Page'))
    );
  }
}