import 'dart:convert';
import 'package:desafio_flutter/app/data/model/details_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:desafio_flutter/app/data/model/movie_model.dart';
import 'package:desafio_flutter/app/data/model/genres_model.dart';

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

  Future<List<MovieModel>> apiSearchMovies(String searchText) async {
    try {
      final response = await httpClient!.get(Uri.parse(
          '$baseUrl/search/movie?query=$searchText&language=pt-BR&api_key=$apiKey'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body)["results"];
        return jsonResponse
            .map((movieJson) => MovieModel.fromJson(movieJson))
            .toList();
      } else {
        debugPrint('Error -apiSearchMovies$searchText');
      }
    } catch (e) {
      debugPrint('Error fetching from API $e');
    }
    return [];
  }

  Future<List<GenresModel>> apiGenresList() async {
    try {
      final response = await httpClient!.get(Uri.parse(
          '$baseUrl/genre/movie/list?language=pt-BR&api_key=$apiKey'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body)["genres"];
        return jsonResponse
            .map((movieJson) => GenresModel.fromJson(movieJson))
            .toList();
      } else {
        debugPrint('Error -apiGenresList');
      }
    } catch (e) {
      debugPrint('Error fetching from API $e');
    }
    return [];
  }

  Future<Object> apiDetailsMovie(int idMovie) async {
    try {
      final response = await httpClient!.get(
          Uri.parse('$baseUrl/movie/$idMovie?language=pt-BR&api_key=$apiKey'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return DetailsModel.fromJson(jsonResponse);
      } else {
        debugPrint('Error -apiDetailsMovie');
      }
    } catch (e) {
      debugPrint('Error fetching from API $e');
    }
    return {};
  }
}
