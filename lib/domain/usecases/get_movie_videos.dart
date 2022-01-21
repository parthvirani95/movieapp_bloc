import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_params.dart';
import 'package:movieapp_bloc/domain/entities/video_entity.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository.dart';
import 'package:movieapp_bloc/domain/usecases/usecase.dart';

class GetMovieVideos extends UseCase<List<VideoEntity>, MovieParams> {
  final MovieRepository repository;
  GetMovieVideos({required this.repository});

  @override
  Future<Either<AppError, List<VideoEntity>>> call(MovieParams movieParams) async {
    return await repository.getVideoDetail(movieParams.id);
  }
}
