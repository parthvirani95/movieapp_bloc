import 'package:movieapp_bloc/domain/entities/movie_search_entity.dart';

class MovieSearchResultModel extends MovieSearchEntity {
  MovieSearchResultModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
          id: id,
          title: title,
          voteAverage: voteAverage,
          releaseDate: releaseDate.toString(),
          posterPath: posterPath,
          backdropPath: backdropPath,
          description: overview,
          voteCount: voteCount,
        );

  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final OriginalLanguage? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  factory MovieSearchResultModel.fromJson(Map<String, dynamic> json) => MovieSearchResultModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: originalLanguageValues.map?[json["original_language"]],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "genre_ids": List<dynamic>.from(genreIds?.map((x) => x) ?? []),
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
