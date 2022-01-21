part of 'movie_videos_bloc.dart';

abstract class MovieVideosEvent extends Equatable {
  const MovieVideosEvent();
}

class MovieVideoDetailLoadEvent extends MovieVideosEvent {
  final int movieId;

  MovieVideoDetailLoadEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
