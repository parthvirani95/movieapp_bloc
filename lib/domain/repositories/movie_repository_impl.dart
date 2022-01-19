import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp_bloc/data/models/movie_detail_model.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<MovieEntity>>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      return movies;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async {
    try {
      final movies = await remoteDataSource.getComingSoon();
      return movies;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow() async {
    try {
      final movies = await remoteDataSource.getPlayingNow();
      return movies;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try {
      final movies = await remoteDataSource.getPopular();
      return movies;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}
