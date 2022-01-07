import 'package:movieapp_bloc/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required this.overview,
    required this.releaseDate,
    required this.adult,
    required this.backdropPath,
    required this.voteCount,
    required this.genreIds,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.posterPath,
    required this.video,
    required this.id,
    required this.voteAverage,
    required this.popularity,
    required this.mediaType,
  }) : super(
            id: id,
            title: title,
            backdropPath: backdropPath,
            posterPath: posterPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            overview: overview);

  final String overview;
  final DateTime releaseDate;
  final bool adult;
  final String backdropPath;
  final int voteCount;
  final List<int> genreIds;
  final String title;
  final OriginalLanguage? originalLanguage;
  final String originalTitle;
  final String posterPath;
  final bool video;
  final int id;
  final double voteAverage;
  final double popularity;
  final MediaType? mediaType;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        voteCount: json["vote_count"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        title: json["title"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        video: json["video"],
        id: json["id"],
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        mediaType: mediaTypeValues.map[json["media_type"]],
      );

  Map<String, dynamic> toJson() => {
        "overview": overview,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "adult": adult,
        "backdrop_path": backdropPath,
        "vote_count": voteCount,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "title": title,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "poster_path": posterPath,
        "video": video,
        "id": id,
        "vote_average": voteAverage,
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse[mediaType],
      };
}

enum MediaType { MOVIE }

final mediaTypeValues = EnumValues({"movie": MediaType.MOVIE});

enum OriginalLanguage { EN, ES, IT, JA }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "it": OriginalLanguage.IT,
  "ja": OriginalLanguage.JA
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap;
  }
}
