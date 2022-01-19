import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/domain/entities/no_params.dart';
import 'package:movieapp_bloc/domain/usecases/get_coming_soon.dart';
import 'package:movieapp_bloc/domain/usecases/get_playing_now.dart';
import 'package:movieapp_bloc/domain/usecases/get_popular.dart';

part 'movie_tabbed_event.dart';
part 'movie_tabbed_state.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetComingSoon getComingSoon;

  MovieTabbedBloc({
    required this.getPopular,
    required this.getPlayingNow,
    required this.getComingSoon,
  }) : super(const MovieTabbedInitial(currentTabIndex: 0)) {
    on<MovieTabbedEvent>((event, emit) {});
    on<MovieTabChangedEvent>(movieTabChangedEvent);
  }

  FutureOr<void> movieTabChangedEvent(MovieTabChangedEvent event, Emitter<MovieTabbedState> emit) async {
    late Either<AppError, List<MovieEntity>> moviesEither;
    switch (event.currentTabIndex) {
      case 0:
        moviesEither = await getPopular(NoParams());
        break;
      case 1:
        moviesEither = await getPlayingNow(NoParams());
        break;
      case 2:
        moviesEither = await getComingSoon(NoParams());
        break;
    }

    emit(
      moviesEither.fold(
        (l) => MovieTabLoadError(currentTabIndex: event.currentTabIndex, errorType: l.errorType),
        (movies) {
          return MovieTabChanged(currentTabIndex: event.currentTabIndex, movies: movies);
        },
      ),
    );
  }
}
