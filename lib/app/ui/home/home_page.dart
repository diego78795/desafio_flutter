import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:desafio_flutter/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_flutter/app/data/model/movie_model.dart';
import 'package:desafio_flutter/app/data/model/genres_model.dart';
import 'package:desafio_flutter/app/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HomeController>(builder: (_) {
      return SafeArea(
          bottom: false,
          child: CustomScrollView(slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              delegate: HeaderSliver(),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: controller.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _.movieList.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 16);
                                },
                                itemBuilder: (context, index) {
                                  return CardMovie(
                                      movie: _.movieList[index],
                                      genres: _.genreMovie(
                                          _.movieList[index].genres));
                                },
                              )),
                    const PaginationWidget(),
                  ])
            ]))
          ]));
    }));
  }
}

class HeaderSliver extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Filmes',
                        style: TextStyle(
                            color: Color.fromRGBO(52, 58, 64, 1),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 18))),
                const Padding(
                    padding: EdgeInsets.only(
                        top: 24, right: 20, bottom: 16, left: 20),
                    child: SearchInput()),
                SizedBox(
                    height: 31,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: _.genresList.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 12);
                      },
                      itemBuilder: (context, index) {
                        return GenreButton(
                            genre: _.genresList[index],
                            genreSelected: _.genreSelected.name);
                      },
                    ))
              ],
            ));
      },
    );
  }

  @override
  double get maxExtent => 210;

  @override
  double get minExtent => 210;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    var searchText = TextEditingController();
    return GetBuilder<HomeController>(
      builder: (_) {
        searchText.text = _.searchText;
        return TextField(
          controller: searchText,
          onChanged: (value) => {_.searchText = value},
          onSubmitted: (text) => _.handleSearchMovie(),
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
          onPressed: () async => {
            genre.name == genreSelected
                ? await _.handleRemoveGenreMovie()
                : await _.handleGenreMovie(genre)
          },
          style: ButtonStyle(
            side: MaterialStatePropertyAll<BorderSide>(BorderSide(
                color: genre.name == genreSelected
                    ? Colors.transparent
                    : const Color.fromRGBO(241, 243, 245, 1),
                width: 1)),
            backgroundColor: MaterialStatePropertyAll<Color>(
                genre.name == genreSelected
                    ? const Color.fromRGBO(0, 56, 76, 1)
                    : Colors.transparent),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26))),
          ),
          child: Text(genre.name,
              textAlign: TextAlign.center,
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
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 520,
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
                            ? Image(
                                image: CachedNetworkImageProvider(
                                  'https://image.tmdb.org/t/p/original${movie.img}',
                                  maxHeight: 520,
                                ),
                                fit: BoxFit.fitHeight,
                              )
                            : Container(
                                height: 520.0,
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

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return _.searchText == "" && _.genreSelected.id == 0
            ? const Row(children: [])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    if (_.pagination != 1)
                      IconButton(
                          onPressed: () => _.handlePagination(-1),
                          icon: const Icon(Icons.arrow_back_ios)),
                    Text('${_.pagination}'),
                    IconButton(
                        onPressed: () => _.handlePagination(1),
                        icon: const Icon(Icons.arrow_forward_ios))
                  ]);
      },
    );
  }
}
