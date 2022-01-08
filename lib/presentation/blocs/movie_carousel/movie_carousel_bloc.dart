import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/domain/entities/no_params.dart';
import 'package:movieapp_bloc/domain/usecases/get_trending.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;

  MovieCarouselBloc({
    required this.getTrending,
    required this.movieBackdropBloc,
  }) : super(MovieCarouselInitial()) {
    on<MovieCarouselEvent>((event, emit) {});
    on<CarouselLoadEvent>(_carouselLoadEvent);
  }

  Future<FutureOr<void>> _carouselLoadEvent(
      CarouselLoadEvent event, Emitter<MovieCarouselState> emit) async {
    final movieEither = await getTrending(NoParams());

    movieEither.fold(
      (error) => emit(MovieCarouselError()),
      (movies) {
        movieBackdropBloc
            .add(MovieBackdropChangedEvent(movie: movies[event.defaultIndex]));

        emit(MovieCarouselLoaded(
            movies: movies, defaultIndex: event.defaultIndex));
      },
    );
  }
}
