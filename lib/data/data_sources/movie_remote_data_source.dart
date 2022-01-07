import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:movieapp_bloc/data/core/api_client.dart';
import 'package:movieapp_bloc/data/core/api_constants.dart';
import 'package:movieapp_bloc/data/models/movie_model.dart';
import 'package:movieapp_bloc/data/models/movies_result_model.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';

abstract class MovieRemoteDataSource {
  Future<Either<AppError, List<MovieEntity>>> getTrending();
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow();
  Future<Either<AppError, List<MovieEntity>>> getComingSoon();
  Future<Either<AppError, List<MovieEntity>>> getPopular();
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _apiClient;

  MovieRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Either<AppError, List<MovieEntity>>> getTrending() async {
    try {
      final response = await _apiClient.get('trending/movie/day');

      if (kDebugMode) {
        print(response);
      }
      return Right(MoviesResultModel.fromJson(response).movies);
    } on Exception {
      return const Left(AppError('Something went wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow() async {
    try {
      final response = await _apiClient.get("movie/now_playing");
      if (kDebugMode) {
        print(response);
      }

      return Right(MoviesResultModel.fromJson(response).movies);
    } on Exception {
      return const Left(AppError('Something went wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async {
    try {
      final response = await _apiClient.get("movie/upcoming");
      if (kDebugMode) {
        print(response);
      }

      return Right(MoviesResultModel.fromJson(response).movies);
    } on Exception {
      return const Left(AppError('Something went wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try {
      final response = await _apiClient.get("movie/popular");
      if (kDebugMode) {
        print(response);
      }

      return Right(MoviesResultModel.fromJson(response).movies);
    } on Exception {
      return const Left(AppError('Something went wrong'));
    }
  }
}
