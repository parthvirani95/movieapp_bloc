import 'package:bloc/bloc.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';

class MovieBackdropCubit extends Cubit<MovieEntity> {
  MovieBackdropCubit() : super(MovieEntity());
  void backdropChanged(MovieEntity movie) {
    emit(movie);
  }
}
