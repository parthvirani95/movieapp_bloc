import 'package:equatable/equatable.dart';

class MovieSearchEntity extends Equatable {
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? description;
  final String? posterPath;
  final String? releaseDate;
  final double? voteAverage;
  final int? voteCount;

  MovieSearchEntity({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.description,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [];
}
