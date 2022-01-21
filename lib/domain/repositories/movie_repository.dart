import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/cast_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_detail_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/domain/entities/video_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError, List<MovieEntity>>> getTrending();
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow();
  Future<Either<AppError, List<MovieEntity>>> getComingSoon();
  Future<Either<AppError, List<MovieEntity>>> getPopular();
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id);
  Future<Either<AppError, List<CastEntity>>> getCastCrew(int id);
  Future<Either<AppError, List<VideoEntity>>> getVideoDetail(int id);
}
