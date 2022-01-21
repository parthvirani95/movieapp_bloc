part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object?> get props => [];
}

class MovieSearchLoadEvent extends MovieSearchEvent {
  final String query;

  MovieSearchLoadEvent({required this.query});

  @override
  List<Object?> get props => [this.query];
}
