part of 'movie_tabbed_bloc.dart';

abstract class MovieTabbedState extends Equatable {
  final int currentTabIndex;

  const MovieTabbedState({required this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}

class MovieTabLoading extends MovieTabbedState {
  MovieTabLoading({required int currentTabIndex}) : super(currentTabIndex: currentTabIndex);
}

class MovieTabbedInitial extends MovieTabbedState {
  final int currentTabIndex;
  const MovieTabbedInitial({required this.currentTabIndex}) : super(currentTabIndex: currentTabIndex);
}

class MovieTabChanged extends MovieTabbedState {
  final List<MovieEntity> movies;
  const MovieTabChanged({required int currentTabIndex, required this.movies}) : super(currentTabIndex: currentTabIndex);

  @override
  List<Object> get props => [currentTabIndex, movies];
}

class MovieTabLoadError extends MovieTabbedState {
  final AppErrorType errorType;

  const MovieTabLoadError({required int currentTabIndex, required this.errorType}) : super(currentTabIndex: currentTabIndex);
}
