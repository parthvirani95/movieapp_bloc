import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movieapp_bloc/data/core/api_client.dart';
import 'package:movieapp_bloc/data/models/CastAndCrewResult.dart';
import 'package:movieapp_bloc/data/models/movie_detail_model.dart';
import 'package:movieapp_bloc/data/models/movie_search_model.dart';
import 'package:movieapp_bloc/data/models/movie_search_result_model.dart';
import 'package:movieapp_bloc/data/models/movies_result_model.dart';
import 'package:movieapp_bloc/data/models/video_model.dart';
import 'package:movieapp_bloc/data/models/video_result_model.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';

abstract class MovieRemoteDataSource {
  Future<Either<AppError, List<MovieEntity>>> getTrending();
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow();
  Future<Either<AppError, List<MovieEntity>>> getComingSoon();
  Future<Either<AppError, List<MovieEntity>>> getPopular();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCastCrew(int id);
  Future<List<VideoResultModel>> getVideoDetail(int id);
  Future<List<MovieSearchResultModel>> getMovieSearch(String query);
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
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
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
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
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
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
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
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _apiClient.get('movie/$id');
    if (kDebugMode) {
      print(response);
    }
    final movie = MovieDetailModel.fromJson(response);
    return movie;
  }

  @override
  Future<MovieDetailModel> getCastAndCrew(int id) async {
    final response = await _apiClient.get('movie/$id');
    if (kDebugMode) {
      print(response);
    }
    final movie = MovieDetailModel.fromJson(response);
    return movie;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final response = await _apiClient.get('movie/$id/credits');
    final cast = CastCrewModel.fromJson(response).cast;
    // print(cast);
    return cast!;
  }

  Future<List<VideoResultModel>> getVideoDetail(int id) async {
    final response = await _apiClient.get('movie/$id/videos');
    final videos = VideoModel.fromJson(response).videos;
    return videos;
  }

  @override
  Future<List<MovieSearchResultModel>> getMovieSearch(String query) async {
    Map<dynamic, dynamic> searchParams = {'query': '$query'};
    final response = await _apiClient.get('search/movie', params: searchParams);
    final searchResponse = MovieSearchModel.fromJson(response).results;
    return searchResponse;
  }
}
