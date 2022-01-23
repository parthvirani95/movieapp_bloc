part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
  @override
  List<Object> get props => [];
}

class LoadFavouriteMovieEvent extends FavoriteEvent {
  LoadFavouriteMovieEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavoriteMovieEvent extends FavoriteEvent {
  final int movieId;
  DeleteFavoriteMovieEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class ToggleFavoriteMovieEvent extends FavoriteEvent {
  final MovieEntity movieEntity;
  final bool isFavorite;

  ToggleFavoriteMovieEvent({required this.movieEntity, required this.isFavorite});

  @override
  List<Object> get props => [movieEntity, isFavorite];
}

class CheckIfFavoriteMovieEvent extends FavoriteEvent {
  final int movieId;

  CheckIfFavoriteMovieEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
