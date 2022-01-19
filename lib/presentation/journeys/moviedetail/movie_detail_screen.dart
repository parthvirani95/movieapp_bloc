import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/di/get_it.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp_bloc/presentation/journeys/moviedetail/big_poster.dart';
import 'package:movieapp_bloc/presentation/journeys/moviedetail/movie_detail_arguments.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({
    Key? key,
    required this.movieDetailArguments,
  })  : assert(movieDetailArguments != null, 'argument must not be null'),
        super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _movieDetailBloc.add(MovieDetailLoadEvent(movieId: widget.movieDetailArguments.movieId));
  }

  @override
  void dispose() {
    _movieDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MovieDetailBloc>.value(
        value: _movieDetailBloc,
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BigPoster(movie: movieDetail),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_16.w,
                    ),
                    //2
                    child: Text(
                      movieDetail.overview ?? '',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              );
            } else if (state is MovieDetailError) {
              return Container();
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
