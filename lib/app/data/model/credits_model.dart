class CreditsModel {
  int id = 0;
  List<dynamic> cast = [];
  List<dynamic> crew = [];

  CreditsModel();

  CreditsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cast = json['cast'];
    crew = json['crew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cast'] = cast;
    data['crew'] = crew;
    return data;
  }
}
