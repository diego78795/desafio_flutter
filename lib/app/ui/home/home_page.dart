import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:desafio_flutter/app/data/model/movie_model.dart';
import 'package:desafio_flutter/app/data/model/genres_model.dart';
import 'package:desafio_flutter/app/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HomeController>(builder: (_) {
      return SafeArea(
          child: Center(
              child: controller.isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: 320,
                      child: ListView(shrinkWrap: true, children: [
                        SizedBox(
                            height: 28,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _.genresList.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 12);
                              },
                              itemBuilder: (context, index) {
                                return GenreButton(
                                    genre: _.genresList[index],
                                    genreSelected: _.genreSelected);
                              },
                            )),
                        const SizedBox(height: 39),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _.movieList.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 16);
                          },
                          itemBuilder: (context, index) {
                            return CardMovie(
                                movie: _.movieList[index],
                                genres:
                                    _.genreMovie(_.movieList[index].genres));
                          },
                        )
                      ]))));
    }));
  }
}

class GenreButton extends StatelessWidget {
  const GenreButton(
      {super.key, required this.genre, required this.genreSelected});

  final GenresModel genre;
  final String genreSelected;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return ElevatedButton(
          onPressed: () async => {await _.handleGenreMovie(genre)},
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                genre.name == genreSelected
                    ? const Color.fromRGBO(0, 56, 76, 1)
                    : const Color.fromRGBO(241, 243, 245, 1)),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26))),
          ),
          child: Text(genre.name,
              style: TextStyle(
                color: genre.name == genreSelected
                    ? const Color.fromRGBO(241, 243, 245, 1)
                    : const Color.fromRGBO(0, 56, 76, 1),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
                fontSize: 12,
              )),
        );
      },
    );
  }
}

class CardMovie extends StatelessWidget {
  const CardMovie({super.key, required this.movie, required this.genres});

  final MovieModel movie;
  final String genres;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 470.0,
        width: 320.0,
        child: Stack(fit: StackFit.expand, children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.black],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            child: FittedBox(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w300${movie.img}',
                      fit: BoxFit.fitHeight,
                    ))),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  )),
                  const SizedBox(height: 9),
                  Text(
                    genres,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  )
                ],
              ))
        ]));
  }
}
