import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_params.dart';
import 'package:movieapp_bloc/domain/entities/video_entity.dart';
import 'package:movieapp_bloc/domain/usecases/get_movie_videos.dart';

part 'movie_videos_event.dart';
part 'movie_videos_state.dart';

class MovieVideosBloc extends Bloc<MovieVideosEvent, MovieVideosState> {
  GetMovieVideos getMovieVideos;

  MovieVideosBloc({required this.getMovieVideos}) : super(MovieVideosInitial()) {
    on<MovieVideosEvent>((event, emit) async {
      if (event is MovieVideoDetailLoadEvent) {
        Either<AppError, List<VideoEntity>> eitherResponse = await getMovieVideos(MovieParams(id: event.movieId));
        emit(eitherResponse.fold((l) => MovieVideosError(), (videoEntity) => MovieVideosLoaded(videoEntity: videoEntity)));
      }
    });
  }
}
