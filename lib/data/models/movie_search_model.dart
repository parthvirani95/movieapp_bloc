// To parse this JSON data, do
//
//     final movieSearchModel = movieSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:movieapp_bloc/data/models/movie_search_result_model.dart';

MovieSearchModel movieSearchModelFromJson(String str) => MovieSearchModel.fromJson(json.decode(str));

String movieSearchModelToJson(MovieSearchModel data) => json.encode(data.toJson());

class MovieSearchModel {
  MovieSearchModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieSearchResultModel> results;
  final int totalPages;
  final int totalResults;

  factory MovieSearchModel.fromJson(Map<String, dynamic> json) => MovieSearchModel(
        page: json["page"],
        results: List<MovieSearchResultModel>.from(json["results"].map((x) => MovieSearchResultModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
