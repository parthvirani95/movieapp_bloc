import 'package:flutter/material.dart';
import 'package:movieapp_bloc/common/constants/route_constants.dart';
import 'package:movieapp_bloc/presentation/journeys/favorite_movie/favorite_screen.dart';
import 'package:movieapp_bloc/presentation/journeys/home/home_screen.dart';
import 'package:movieapp_bloc/presentation/journeys/moviedetail/movie_detail_screen.dart';
import 'package:movieapp_bloc/presentation/journeys/watch_video/watch_video_screen.dart';

import 'journeys/moviedetail/movie_detail_arguments.dart';
import 'journeys/watch_video/watch_video_arguments.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => HomeScreen(),
        RouteList.home: (context) => HomeScreen(),
        RouteList.movieDetail: (context) => MovieDetailScreen(
              movieDetailArguments: setting.arguments as MovieDetailArguments,
            ),
        RouteList.watchTrailer: (context) => WatchVideoScreen(
              watchVideoArguments: setting.arguments as WatchVideoArguments,
            ),
        RouteList.favorite: (context) => FavoriteScreen(),
      };
}
