import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/constants/translation_constants.dart';
import 'package:movieapp_bloc/common/extension/string_extension.dart';
import 'package:movieapp_bloc/common/extension/theme_extension.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_search/movie_search_bloc.dart';
import 'package:movieapp_bloc/presentation/journeys/search_movie/search_movie_card.dart';
import 'package:movieapp_bloc/presentation/themes/app_color.dart';
import 'package:movieapp_bloc/presentation/widgets/app_error_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  final MovieSearchBloc movieSearchBloc;

  CustomSearchDelegate({required this.movieSearchBloc});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: query.isEmpty ? null : () => query = '',
        icon: Icon(
          Icons.clear,
          color: query.isEmpty ? Colors.grey : AppColor.royalBlue,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: Sizes.dimen_12.h,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    movieSearchBloc.add(MovieSearchLoadEvent(query: query));

    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      bloc: movieSearchBloc,
      builder: (context, state) {
        if (state is MovieSearchError) {
          return AppErrorWidget(
            errorType: state.appErrorType,
            onPressed: () => movieSearchBloc.add(
              MovieSearchLoadEvent(query: query),
            ),
          );
        } else if (state is MovieSearchLoaded) {
          final movies = state.searchMovieList;

          if (movies.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_64.w),
                child: Text(
                  TranslationConstants.noMoviesSearched.translate(context),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => SearchMovieCard(
              movieEntity: movies[index],
            ),
            itemCount: movies.length,
            scrollDirection: Axis.vertical,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.greySubtitle1,
      ),
    );
  }
}
