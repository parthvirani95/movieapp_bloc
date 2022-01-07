import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/domain/entities/no_params.dart';
import 'package:movieapp_bloc/domain/usecases/get_trending.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;

void main() async {
  unawaited(getIt.init());

  GetTrending getTrending = getIt.getItInstance<GetTrending>();

  final Either<AppError, List<MovieEntity>> eitherResponse =
      await getTrending(NoParams());

  eitherResponse.fold(
    (l) {
      if (kDebugMode) {
        print('error');
        print(l);
      }
    },
    (r) {
      if (kDebugMode) {
        print('list of movies');
        print(r);
      }
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
