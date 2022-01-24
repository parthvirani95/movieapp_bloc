import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/domain/entities/no_params.dart';
import 'package:movieapp_bloc/domain/usecases/get_trending.dart';
import 'package:movieapp_bloc/presentation/cubit/loading/loading_cubit.dart';
import 'package:movieapp_bloc/presentation/cubit/movie_backdrop/movie_backdrop_cubit.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropCubit movieBackdropCubit;
  final LoadingCubit loadingCubit;

  MovieCarouselBloc({
    required this.getTrending,
    required this.movieBackdropCubit,
    required this.loadingCubit,
  }) : super(MovieCarouselInitial()) {
    on<MovieCarouselEvent>((event, emit) {});
    on<CarouselLoadEvent>(_carouselLoadEvent);
  }

  Future<FutureOr<void>> _carouselLoadEvent(CarouselLoadEvent event, Emitter<MovieCarouselState> emit) async {
    loadingCubit.show();

    final movieEither = await getTrending(NoParams());

    movieEither.fold(
      (error) => emit(MovieCarouselError(errorType: error.errorType)),
      (movies) {
        movieBackdropCubit.backdropChanged(movies[event.defaultIndex]);
        emit(MovieCarouselLoaded(movies: movies, defaultIndex: event.defaultIndex));
      },
    );

    loadingCubit.hide();
  }
}
