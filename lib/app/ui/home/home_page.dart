import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:desafio_flutter/app/routes/app_pages.dart';
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
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Text('Filmes',
                                style: TextStyle(
                                    color: Color.fromRGBO(52, 58, 64, 1),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18))),
                        const SearchInput(),
                        const SizedBox(height: 16),
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

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    var searchText = TextEditingController();
    return GetBuilder<HomeController>(
      builder: (_) {
        return TextField(
          controller: searchText,
          onSubmitted: (text) => _.searchMovie(text),
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(241, 243, 245, 1),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Color.fromRGBO(0, 56, 76, 1)),
                  borderRadius: BorderRadius.circular(100)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(100)),
              hintText: "Pesquise filmes",
              prefixIcon: Image.asset('assets/images/icons/searchIcon.png')
              /* IconButton(
                icon: const Icon(Icons.sear),
                onPressed: () => _.searchMovie(searchText.text.toString()),
              ) */
              ),
        );
      },
    );
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
        return TextButton(
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
    return GestureDetector(
        onTap: () => {
              Get.toNamed(Routes.details, arguments: {"movie_id": movie.id})
            },
        child: SizedBox(
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
                        child: movie.img != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w300${movie.img}',
                                fit: BoxFit.fitHeight,
                              )
                            : Container(
                                height: 470.0,
                                width: 320.0,
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
                              ))),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
            ])));
  }
}
