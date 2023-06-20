import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_flutter/app/controllers/details_controller.dart';

class DetailsPage extends GetView<DetailsController> {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<DetailsController>(builder: (_) {
      final money = NumberFormat("#,##0");
      return SafeArea(
          child: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(children: [
                  Stack(fit: StackFit.loose, children: [
                    Container(
                      height: 300,
                      color: const Color.fromRGBO(245, 245, 245, 1),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding:
                                EdgeInsets.only(top: 24, bottom: 60, left: 20),
                            child: SizedBox(
                                height: 32, width: 83, child: BackButton())),
                        Center(child: CardMovie(img: _.details.img)),
                      ],
                    )
                  ]),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_.details.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                  color: Color.fromRGBO(0, 56, 76, 1),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24)),
                          const Text('/10',
                              style: TextStyle(
                                  color: Color.fromRGBO(134, 142, 150, 1),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                        ],
                      )),
                  Text(_.details.title.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color.fromRGBO(52, 58, 64, 1),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(height: 12),
                  Text('Titulo original: ${_.details.originalTitle}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color.fromRGBO(94, 103, 112, 1),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 10)),
                  const SizedBox(height: 32),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ContainerInfo(
                        field: 'Ano: ',
                        info: _.details.releaseDate.substring(0, 4)),
                    const SizedBox(width: 12),
                    ContainerInfo(
                        field: 'Duração: ',
                        info:
                            '${_.details.runtime ~/ 60}h ${_.details.runtime % 60} min'),
                  ]),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: _.details.genres
                        .map((genre) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            child: ContainerGenre(
                                genre: genre['name'].toUpperCase())))
                        .toList(),
                  ),
                  const SizedBox(height: 56),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextMovie(
                                title: 'Descrição', text: _.details.overview),
                            const SizedBox(height: 49),
                            ContainerInfo(
                                field: 'ORÇAMENTO: ',
                                info: '\$ ${money.format(_.details.budget)}'),
                            const SizedBox(height: 4),
                            ContainerInfo(
                                field: 'PRODUTORAS: ',
                                info: _.productionCompanies),
                            const SizedBox(height: 40),
                            TextMovie(title: 'Diretor', text: _.director),
                            const SizedBox(height: 32),
                            TextMovie(title: 'Elenco', text: _.cast),
                            const SizedBox(height: 40),
                          ]))
                ]));
    }));
  }
}

class BackButton extends GetView<DetailsController> {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {Get.back()},
      style: ButtonStyle(
          side: const MaterialStatePropertyAll<BorderSide>(
              BorderSide(width: 1, color: Color.fromRGBO(250, 250, 250, 1))),
          elevation: const MaterialStatePropertyAll<double>(5),
          backgroundColor: const MaterialStatePropertyAll<Color>(
              Color.fromRGBO(255, 255, 255, 1)),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Color.fromRGBO(250, 250, 250, 1), width: 1),
                  borderRadius: BorderRadius.circular(100)))),
      child: const Row(children: [
        Icon(Icons.arrow_back_ios,
            size: 15, color: Color.fromRGBO(109, 112, 112, 1)),
        Text('Voltar',
            style: TextStyle(
                color: Color.fromRGBO(109, 112, 112, 1),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 12))
      ]),
    );
  }
}

class CardMovie extends GetView<DetailsController> {
  const CardMovie({super.key, required this.img});
  final String? img;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 318.0,
        width: 216.0,
        child: FittedBox(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: img != null
                    ? Image(
                        image: CachedNetworkImageProvider(
                          'https://image.tmdb.org/t/p/original$img',
                          maxHeight: 318,
                          maxWidth: 216,
                        ),
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        height: 318.0,
                        width: 216.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(0, 56, 76, 1),
                        ),
                        child: const Center(
                            child: Text('Este filme não possui imagem',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ))),
                      ))));
  }
}

class ContainerInfo extends GetView<DetailsController> {
  const ContainerInfo({super.key, required this.field, required this.info});
  final String field;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromRGBO(241, 243, 245, 1),
      ),
      child: Wrap(
        children: [
          Text(field,
              style: const TextStyle(
                  color: Color.fromRGBO(134, 142, 150, 1),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 12)),
          Text(info,
              style: const TextStyle(
                  color: Color.fromRGBO(52, 58, 64, 1),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 14))
        ],
      ),
    );
  }
}

class ContainerGenre extends GetView<DetailsController> {
  const ContainerGenre({super.key, required this.genre});
  final String genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: const Color.fromRGBO(233, 236, 239, 1), width: 1),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          child: Text(genre,
              style: const TextStyle(
                  color: Color.fromRGBO(94, 103, 112, 1),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 14))),
    );
  }
}

class TextMovie extends GetView<DetailsController> {
  const TextMovie({super.key, required this.title, required this.text});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: const TextStyle(
              color: Color.fromRGBO(94, 103, 112, 1),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: 14)),
      const SizedBox(height: 8),
      Text(text,
          style: const TextStyle(
              color: Color.fromRGBO(52, 58, 64, 1),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 12)),
    ]);
  }
}
