import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_params.dart';
import 'package:movieapp_bloc/domain/entities/no_params.dart';
import 'package:movieapp_bloc/domain/usecases/check_if_movie_favourite.dart';
import 'package:movieapp_bloc/domain/usecases/delete_favorite_movie.dart';
import 'package:movieapp_bloc/domain/usecases/get_favourite_movies.dart';
import 'package:movieapp_bloc/domain/usecases/save_movies.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovies saveMovies;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfFavoriteMovie checkIfFavouriteMovie;

  FavoriteBloc({
    required this.saveMovies,
    required this.getFavoriteMovies,
    required this.deleteFavoriteMovie,
    required this.checkIfFavouriteMovie,
  }) : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) {});
    on<ToggleFavoriteMovieEvent>(toggleFavoriteMovieEvent);
    on<LoadFavouriteMovieEvent>(loadFavoriteMovieEvent);
    on<DeleteFavoriteMovieEvent>(deleteFavoriteMovieEvent);
    on<CheckIfFavoriteMovieEvent>(checkIfFavoriteMovieEvent);
  }

  Future<void> toggleFavoriteMovieEvent(ToggleFavoriteMovieEvent event, Emitter<FavoriteState> emit) async {
    if (event is ToggleFavoriteMovieEvent) {
      if (event.isFavorite) {
        await deleteFavoriteMovie(MovieParams(id: event.movieEntity.id!));
      } else {
        await saveMovies(event.movieEntity);
      }

      final response = await checkIfFavouriteMovie(MovieParams(id: event.movieEntity.id!));
      emit(response.fold((l) => FavoriteMoviesError(appErrorType: l.errorType), (r) => IsFavoriteMovie(isMovieFavorite: r)));
    }
  }

  Future<void> loadFavoriteMovieEvent(LoadFavouriteMovieEvent event, Emitter<FavoriteState> emit) async {
    final Either<AppError, List<MovieEntity>> response = await getFavoriteMovies(NoParams());
    emit(
      response.fold(
        (l) => FavoriteMoviesError(appErrorType: l.errorType),
        (r) => FavoriteMoviesLoaded(r),
      ),
    );
  }

  Future<void> deleteFavoriteMovieEvent(DeleteFavoriteMovieEvent event, Emitter<FavoriteState> emit) async {
    final Either<AppError, List<MovieEntity>> response = await getFavoriteMovies(NoParams());
    emit(
      response.fold(
        (l) => FavoriteMoviesError(appErrorType: l.errorType),
        (r) => FavoriteMoviesLoaded(r),
      ),
    );
  }

  FutureOr<void> checkIfFavoriteMovieEvent(CheckIfFavoriteMovieEvent event, Emitter<FavoriteState> emit) async {
    final response = await checkIfFavouriteMovie(MovieParams(id: event.movieId));

    emit(response.fold(
      (l) => FavoriteMoviesError(appErrorType: l.errorType),
      (result) => IsFavoriteMovie(isMovieFavorite: result),
    ));
  }
}
