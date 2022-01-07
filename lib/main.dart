import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movieapp_bloc/data/core/api_client.dart';
import 'package:movieapp_bloc/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/domain/entities/no_params.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository_impl.dart';
import 'package:movieapp_bloc/domain/usecases/get_trending.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;

void main() async {
  //Not Needed because of DI
  MovieRemoteDataSource dataSource =
      MovieRemoteDataSourceImpl(ApiClient(Client()));
  // dataSource.getTrending();
  // dataSource.getPopular();

  MovieRepository movieRepository = MovieRepositoryImpl(dataSource);
  // movieRepository.getTrending();

  GetTrending getTrending = GetTrending(movieRepository);
  // getTrending();

  final Either<AppError, List<MovieEntity>> eitherResponse =
      await getTrending(NoParams());

  // unawaited(getIt.setup());

  // final Either<AppError, List<MovieEntity>> eitherResponse =
  //     getIt.getItInstance<GetTrending>();

  eitherResponse.fold(
    (l) {
      print('error');
      print(l);
    },
    (r) {
      print('list of movies');
      print(r);
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scaffold(),
    );
  }
}
