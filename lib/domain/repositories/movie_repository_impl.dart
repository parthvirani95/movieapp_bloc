import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/data/data_sources/movie_local_data_source.dart';
import 'package:movieapp_bloc/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp_bloc/data/models/movie_detail_model.dart';
import 'package:movieapp_bloc/data/tables/movie_table.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/cast_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_search_entity.dart';
import 'package:movieapp_bloc/domain/entities/video_entity.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<AppError, List<MovieEntity>>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      await Future.delayed(Duration(seconds: 5));
      return movies;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async {
    try {
      final movies = await remoteDataSource.getComingSoon();
      await Future.delayed(Duration(seconds: 5));
      return movies;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow() async {
    try {
      final movies = await remoteDataSource.getPlayingNow();
      await Future.delayed(Duration(seconds: 5));
      return movies;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try {
      final movies = await remoteDataSource.getPopular();
      await Future.delayed(Duration(seconds: 5));
      return movies;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      await Future.delayed(Duration(seconds: 5));
      return Right(movie);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CastEntity>>> getCastCrew(int id) async {
    try {
      final cast = await remoteDataSource.getCastCrew(id);
      await Future.delayed(Duration(seconds: 5));

      return Right(cast);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<VideoEntity>>> getVideoDetail(int id) async {
    try {
      final video = await remoteDataSource.getVideoDetail(id);
      await Future.delayed(Duration(seconds: 5));
      return Right(video);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieSearchEntity>>> getMovieSearch(String query) async {
    try {
      final movieSearchResult = await remoteDataSource.getMovieSearch(query);
      await Future.delayed(Duration(seconds: 5));
      return Right(movieSearchResult);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> saveMovie(MovieEntity movieEntity) async {
    try {
      final response = await localDataSource.saveMovie(MovieTable.fromMovieEntity(movieEntity));
      await Future.delayed(Duration(seconds: 5));
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIfMovieFavorite(int movieId) async {
    try {
      final response = await localDataSource.checkIfMovieFavourite(movieId);
      await Future.delayed(Duration(seconds: 5));
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteFavoriteMovie(int movieId) async {
    try {
      final response = await localDataSource.deleteMovie(movieId);
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies() async {
    try {
      final response = await localDataSource.getMovies();

      print(response);

      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }
}
