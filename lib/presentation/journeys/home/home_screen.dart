import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_bloc/di/get_it.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_search/movie_search_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp_bloc/presentation/cubit/movie_backdrop/movie_backdrop_cubit.dart';
import 'package:movieapp_bloc/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:movieapp_bloc/presentation/journeys/home/movie_carousel/movie_carousel_widget.dart';
import 'package:movieapp_bloc/presentation/journeys/home/movie_tabbed/movie_tabbed_widget.dart';
import 'package:movieapp_bloc/presentation/widgets/app_error_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCarouselBloc movieCarouselBloc;
  late MovieBackdropCubit movieBackdropCubit;
  late MovieTabbedBloc movieTabbedBloc;
  late MovieSearchBloc movieSearchBloc;

  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    movieCarouselBloc.add(CarouselLoadEvent());

    movieBackdropCubit = movieCarouselBloc.movieBackdropCubit;
    movieTabbedBloc = getItInstance<MovieTabbedBloc>();
    movieSearchBloc = getItInstance<MovieSearchBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselBloc.close();
    movieBackdropCubit.close();
    movieTabbedBloc.close();
    movieSearchBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => movieCarouselBloc),
          BlocProvider(create: (_) => movieBackdropCubit),
          BlocProvider(create: (_) => movieTabbedBloc),
          BlocProvider(create: (_) => movieSearchBloc),
        ],
        child: Scaffold(
          drawer: const NavigationDrawer(),
          body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
            bloc: movieCarouselBloc,
            builder: (context, state) {
              if (state is MovieCarouselLoaded) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.6,
                      child: MovieCarouselWidget(
                        movies: state.movies,
                        defaultIndex: state.defaultIndex,
                      ),
                    ),
                    const FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 0.4,
                      child: MovieTabbedWidget(),
                    ),
                  ],
                );
              } else if (state is MovieCarouselError) {
                return AppErrorWidget(
                  errorType: state.errorType,
                  onPressed: () => movieCarouselBloc.add(CarouselLoadEvent()),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
