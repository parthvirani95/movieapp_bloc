import 'package:flutter/material.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/domain/entities/movie_entity.dart';
import 'package:movieapp_bloc/presentation/journeys/home/movie_tabbed/movie_tab_card_widget.dart';

class MovieListViewBuilder extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieListViewBuilder({Key? key, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final MovieEntity movie = movies[index];
        return MovieTabCardWidget(
          movieId: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(width: 14.w);
      },
      itemCount: movies.length,
    );
  }
}
