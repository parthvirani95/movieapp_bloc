import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/cast_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_params.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository.dart';
import 'package:movieapp_bloc/domain/usecases/usecase.dart';

class GetCast extends UseCase<List<CastEntity>, MovieParams> {
  final MovieRepository movieRepository;

  GetCast({required this.movieRepository});

  @override
  Future<Either<AppError, List<CastEntity>>> call(params) async {
    return await movieRepository.getCastCrew(params.id);
  }
}
