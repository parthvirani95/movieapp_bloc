import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_search_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_search_params.dart';
import 'package:movieapp_bloc/domain/usecases/get_movie_search.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final GetMovieSearch getMovieSearch;

  MovieSearchBloc({required this.getMovieSearch}) : super(MovieSearchInitial()) {
    on<MovieSearchEvent>((event, emit) {});
    on<MovieSearchLoadEvent>(movieSearchLoadEvent);
  }

  FutureOr<void> movieSearchLoadEvent(MovieSearchLoadEvent event, Emitter<MovieSearchState> emit) async {
    final Either<AppError, List<MovieSearchEntity>> eitherResponse = await getMovieSearch(MovieSearchParams(query: event.query));

    emit(
      eitherResponse.fold(
        (error) => MovieSearchError(appErrorType: error.errorType),
        (result) => MovieSearchLoaded(searchMovieList: result),
      ),
    );
  }
}
