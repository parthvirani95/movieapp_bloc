import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movieapp_bloc/data/core/api_client.dart';
import 'package:movieapp_bloc/data/data_sources/language_local_data_source.dart';
import 'package:movieapp_bloc/data/data_sources/movie_local_data_source.dart';
import 'package:movieapp_bloc/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp_bloc/domain/repositories/app_repository.dart';
import 'package:movieapp_bloc/domain/repositories/app_repository_impl.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository.dart';
import 'package:movieapp_bloc/domain/repositories/movie_repository_impl.dart';
import 'package:movieapp_bloc/domain/usecases/check_if_movie_favourite.dart';
import 'package:movieapp_bloc/domain/usecases/delete_favorite_movie.dart';
import 'package:movieapp_bloc/domain/usecases/get_cast.dart';
import 'package:movieapp_bloc/domain/usecases/get_coming_soon.dart';
import 'package:movieapp_bloc/domain/usecases/get_favourite_movies.dart';
import 'package:movieapp_bloc/domain/usecases/get_movie_detail.dart';
import 'package:movieapp_bloc/domain/usecases/get_movie_search.dart';
import 'package:movieapp_bloc/domain/usecases/get_movie_videos.dart';
import 'package:movieapp_bloc/domain/usecases/get_playing_now.dart';
import 'package:movieapp_bloc/domain/usecases/get_popular.dart';
import 'package:movieapp_bloc/domain/usecases/get_preferred_language.dart';
import 'package:movieapp_bloc/domain/usecases/get_trending.dart';
import 'package:movieapp_bloc/domain/usecases/save_movies.dart';
import 'package:movieapp_bloc/domain/usecases/update_language.dart';
import 'package:movieapp_bloc/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_search/movie_search_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_videos/movie_videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl());

  getItInstance.registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));

  getItInstance.registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));

  getItInstance.registerLazySingleton<GetPlayingNow>(() => GetPlayingNow(getItInstance()));

  getItInstance.registerLazySingleton<GetComingSoon>(() => GetComingSoon(getItInstance()));

  getItInstance.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      getItInstance(),
      getItInstance(),
    ),
  );

  getItInstance.registerFactory(() => MovieCarouselBloc(getTrending: getItInstance(), movieBackdropBloc: getItInstance()));

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(
    () => MovieTabbedBloc(
      getPopular: getItInstance(),
      getPlayingNow: getItInstance(),
      getComingSoon: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(repository: getItInstance()));

  getItInstance.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: getItInstance(),
      castBloc: getItInstance(),
      videosBloc: getItInstance(),
      favoriteBloc: getItInstance(),
    ),
  );

  getItInstance.registerFactory(() => CastBloc(getCast: getItInstance()));

  getItInstance.registerFactory(() => MovieVideosBloc(getMovieVideos: getItInstance()));

  getItInstance.registerLazySingleton<GetCast>(() => GetCast(movieRepository: getItInstance()));

  getItInstance.registerLazySingleton<GetMovieVideos>(() => GetMovieVideos(repository: getItInstance()));

  getItInstance.registerLazySingleton<GetMovieSearch>(() => GetMovieSearch(movieRepository: getItInstance()));

  getItInstance.registerFactory<MovieSearchBloc>(() => MovieSearchBloc(getMovieSearch: getItInstance()));

  getItInstance.registerLazySingleton<SaveMovies>(
    () => SaveMovies(movieRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<GetFavoriteMovies>(
    () => GetFavoriteMovies(movieRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
    () => DeleteFavoriteMovie(movieRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(
    () => CheckIfFavoriteMovie(movieRepository: getItInstance()),
  );

  getItInstance.registerFactory<FavoriteBloc>(
    () => FavoriteBloc(
        checkIfFavouriteMovie: getItInstance(),
        deleteFavoriteMovie: getItInstance(),
        getFavoriteMovies: getItInstance(),
        saveMovies: getItInstance()),
  );

  getItInstance.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(languageLocalDataSource: getItInstance()),
  );

  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
    () => LanguageLocalDataSourceImpl(),
  );

  getItInstance.registerLazySingleton<GetPreferredLanguage>(
    () => GetPreferredLanguage(appRepository: getItInstance()),
  );

  getItInstance.registerLazySingleton<UpdateLanguage>(
    () => UpdateLanguage(appRepository: getItInstance()),
  );

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));
}
