import 'package:flutter/material.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/presentation/journeys/home/movie_carousel/movie_backdrop_widget.dart';
import 'package:movieapp_bloc/presentation/journeys/home/movie_carousel/movie_data_widget.dart';
import 'package:movieapp_bloc/presentation/journeys/home/movie_carousel/movie_page_view.dart';
import 'package:movieapp_bloc/presentation/widgets/movie_app_bar.dart';
import 'package:movieapp_bloc/presentation/widgets/seprator.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieCarouselWidget(
      {Key? key, required this.movies, required this.defaultIndex})
      : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MovieBackdropWidget(),
        Column(
          children: [
            MovieAppBar(),
            MoviePageView(
              movies: movies,
              initialPage: defaultIndex,
            ),
            MovieDataWidget(),
            Separator(),
          ],
        ),
      ],
    );
  }
}
