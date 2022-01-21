part of 'movie_videos_bloc.dart';

abstract class MovieVideosState extends Equatable {
  const MovieVideosState();
}

class MovieVideosInitial extends MovieVideosState {
  @override
  List<Object> get props => [];
}

class MovieVideosError extends MovieVideosState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class MovieVideosLoaded extends MovieVideosState {
  List<VideoEntity> videoEntity;

  MovieVideosLoaded({required this.videoEntity});

  @override
  List<Object?> get props => [videoEntity];
}
