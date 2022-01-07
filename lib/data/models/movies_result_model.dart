// To parse this JSON data, do
//
//     final moviesResultModel = moviesResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:movieapp_bloc/data/models/movie_model.dart';

MoviesResultModel moviesResultModelFromJson(String str) =>
    MoviesResultModel.fromJson(json.decode(str));

String moviesResultModelToJson(MoviesResultModel data) =>
    json.encode(data.toJson());

class MoviesResultModel {
  MoviesResultModel({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  int? page;
  List<MovieModel> movies;
  int? totalPages;
  int? totalResults;

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) =>
      MoviesResultModel(
        page: json["page"],
        movies: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(movies.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
