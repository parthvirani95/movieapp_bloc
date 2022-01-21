import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_detail_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_params.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository.dart';
import 'package:movieapp_bloc/domain/usecases/usecase.dart';

class GetMovieDetail extends UseCase<MovieDetailEntity, MovieParams> {
  final MovieRepository repository;
  GetMovieDetail({required this.repository});

  @override
  Future<Either<AppError, MovieDetailEntity>> call(MovieParams movieParams) async {
    return await repository.getMovieDetail(movieParams.id);
  }
}
