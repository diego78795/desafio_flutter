import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:desafio_flutter/app/data/model/movie_model.dart';

const baseUrl = "https://api.themoviedb.org/3";

const apiKey = "59584b0ac2fbdd20ba3c1c86f06a7c6d";

class ApiClient {
  final http.Client? httpClient;

  ApiClient({@required this.httpClient});
  Future<List<MovieModel>> apiGenreMovies(int idGenre) async {
    try {
      final response = await httpClient!.get(Uri.parse(
          '$baseUrl/discover/movie?with_genres=$idGenre&language=pt-BR&api_key=$apiKey'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body)["results"];
        return jsonResponse
            .map((movieJson) => MovieModel.fromJson(movieJson))
            .toList();
      } else {
        debugPrint('Error -apiGenreMovies$idGenre');
      }
    } catch (e) {
      debugPrint('Error fetching from API $e');
    }
    return [];
  }
}
