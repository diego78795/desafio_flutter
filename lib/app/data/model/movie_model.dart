class MovieModel {
  int id = 0;
  String? img = '';
  String title = '';
  List<dynamic> genres = [];

  MovieModel();

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['poster_path'];
    title = json['title'] ?? json['name'];
    genres = json['genre_ids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img'] = img;
    data['title'] = title;
    data['genres'] = genres;
    return data;
  }
}
