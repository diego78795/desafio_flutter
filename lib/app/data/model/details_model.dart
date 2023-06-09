class DetailsModel {
  int id = 0;
  String? img = '';
  String title = '';
  String voteAverage = '';
  String originalTitle = '';
  String releaseDate = '';
  String runtime = '';
  List<dynamic> genres = [];
  String overview = '';
  String budget = '';
  List<dynamic> productionCompanies = [];

  DetailsModel();

  DetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['poster_path'];
    voteAverage = json['vote_average'];
    title = json['title'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    runtime = json['runtime'];
    genres = json['genres'];
    overview = json['overview'];
    budget = json['budget'];
    productionCompanies = json['production_companies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img'] = img;
    data['voteAverage'] = voteAverage;
    data['title'] = title;
    data['originalTitle'] = originalTitle;
    data['releaseDate'] = releaseDate;
    data['runtime'] = runtime;
    data['genres'] = genres;
    data['overview'] = overview;
    data['budget'] = budget;
    data['productionCompanies'] = productionCompanies;
    return data;
  }
}
