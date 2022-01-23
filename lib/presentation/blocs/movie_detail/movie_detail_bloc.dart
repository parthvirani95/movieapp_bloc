import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_detail_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_params.dart';
import 'package:movieapp_bloc/domain/usecases/get_movie_detail.dart';
import 'package:movieapp_bloc/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_videos/movie_videos_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final MovieVideosBloc videosBloc;
  final FavoriteBloc favoriteBloc;

  MovieDetailBloc({required this.getMovieDetail, required this.castBloc, required this.videosBloc, required this.favoriteBloc})
      : super(MovieDetailInitial()) {
    on<MovieDetailEvent>(
      (event, emit) async {
        if (event is MovieDetailLoadEvent) {
          final Either<AppError, MovieDetailEntity> eitherResponse = await getMovieDetail(MovieParams(id: event.movieId));
          emit(
            eitherResponse.fold(
              (error) => MovieDetailError(),
              (movieDetailEntity) => MovieDetailLoaded(movieDetailEntity: movieDetailEntity),
            ),
          );
          favoriteBloc.add(CheckIfFavoriteMovieEvent(movieId: event.movieId));
          castBloc.add(LoadCastEvent(movieId: event.movieId));
          videosBloc.add(MovieVideoDetailLoadEvent(movieId: event.movieId));
        }
      },
    );
  }
}
