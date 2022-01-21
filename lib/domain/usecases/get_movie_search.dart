import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_search_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_search_params.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository.dart';
import 'package:movieapp_bloc/domain/usecases/usecase.dart';

class GetMovieSearch extends UseCase<List<MovieSearchEntity>, MovieSearchParams> {
  final MovieRepository movieRepository;
  GetMovieSearch({required this.movieRepository});

  @override
  Future<Either<AppError, List<MovieSearchEntity>>> call(MovieSearchParams params) async {
    return await movieRepository.getMovieSearch(params.query);
  }
}
