part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {
  @override
  List<Object> get props => [];
}

class MovieSearchError extends MovieSearchState {
  final AppErrorType appErrorType;

  MovieSearchError({required this.appErrorType});

  @override
  List<Object> get props => [];
}

class MovieSearchLoaded extends MovieSearchState {
  final List<MovieSearchEntity> searchMovieList;

  MovieSearchLoaded({required this.searchMovieList});

  @override
  List<Object> get props => [this.searchMovieList];
}
