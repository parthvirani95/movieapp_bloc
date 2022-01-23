import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/constants/translation_constants.dart';
import 'package:movieapp_bloc/common/extension/string_extension.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/di/get_it.dart';
import 'package:movieapp_bloc/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_videos/movie_videos_bloc.dart';
import 'package:movieapp_bloc/presentation/journeys/moviedetail/big_poster.dart';
import 'package:movieapp_bloc/presentation/journeys/moviedetail/cast_widget.dart';
import 'package:movieapp_bloc/presentation/journeys/moviedetail/movie_detail_arguments.dart';
import 'package:movieapp_bloc/presentation/journeys/moviedetail/videos_widget.dart';

import 'big_poster.dart';

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
  late CastBloc _castBloc;
  late MovieVideosBloc _movieVideosBloc;
  late FavoriteBloc _favoriteBloc;
  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _movieDetailBloc.add(MovieDetailLoadEvent(movieId: widget.movieDetailArguments.movieId));

    _castBloc = _movieDetailBloc.castBloc;
    _movieVideosBloc = _movieDetailBloc.videosBloc;
    _favoriteBloc = _movieDetailBloc.favoriteBloc;
  }

  @override
  void dispose() {
    _movieDetailBloc.close();
    _castBloc.close();
    _movieVideosBloc.close();
    _favoriteBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailBloc),
          BlocProvider.value(value: _castBloc),
          BlocProvider.value(value: _movieVideosBloc),
          BlocProvider.value(value: _favoriteBloc),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              // final castEntity = _castBloc.state.
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(movie: movieDetail),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w,
                        vertical: Sizes.dimen_8.h,
                      ),
                      //2
                      child: Text(
                        movieDetail.overview ?? '',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                      child: Text(
                        TranslationConstants.cast.translate(context),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    CastWidget(),
                    VideoWidget(movieVideosBloc: _movieVideosBloc),
                  ],
                ),
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
