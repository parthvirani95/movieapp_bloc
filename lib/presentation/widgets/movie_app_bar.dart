import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_search/movie_search_bloc.dart';
import 'package:movieapp_bloc/presentation/journeys/search_movie/custom_search_movie_delegate.dart';
import 'package:movieapp_bloc/presentation/widgets/logo.dart';

class MovieAppBar extends StatelessWidget {
  MovieAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              'assets/svgs/menu.svg',
              height: Sizes.dimen_12.h,
            ),
          ),
          const Expanded(child: Logo(height: Sizes.dimen_14)),
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  movieSearchBloc: BlocProvider.of<MovieSearchBloc>(context),
                ),
              );
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: Sizes.dimen_12.h,
            ),
          ),
        ],
      ),
    );
  }
}
