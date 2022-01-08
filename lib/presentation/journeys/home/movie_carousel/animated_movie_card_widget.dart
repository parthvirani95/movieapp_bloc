import 'package:flutter/material.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/presentation/journeys/home/movie_carousel/movie_card_widget.dart';

class AniamtedMovieCardWidget extends StatelessWidget {
  final int index;
  final PageController pageController;
  final int movieId;
  final String posterPath;

  const AniamtedMovieCardWidget(
      {Key? key,
      required this.index,
      required this.pageController,
      required this.movieId,
      required this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = (pageController.page! - index);
          value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);

          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn.transform(value) *
                  ScreenUtil.screenHeight *
                  0.35,
              width: Sizes.dimen_230.w,
              child: child,
            ),
          );
        } else {
          print('else');
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height:
                  Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                      ScreenUtil.screenHeight *
                      0.35,
              width: Sizes.dimen_230.w,
              child: child,
            ),
          );
        }
      },
      child: MovieCardWidget(
        movieId: movieId,
        posterPath: posterPath,
      ),
    );
  }
}
