import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movieapp_bloc/common/constants/languages.dart';
import 'package:movieapp_bloc/common/constants/route_constants.dart';
import 'package:movieapp_bloc/common/constants/theme.dart';
import 'package:movieapp_bloc/common/extension/theme_extension.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/di/get_it.dart';
import 'package:movieapp_bloc/presentation/app_localizations.dart';
import 'package:movieapp_bloc/presentation/cubit/language/language_cubit.dart';
import 'package:movieapp_bloc/presentation/cubit/loading/loading_cubit.dart';
import 'package:movieapp_bloc/presentation/cubit/themes/theme_cubit.dart';
import 'package:movieapp_bloc/presentation/fade_page_route_builder.dart';
import 'package:movieapp_bloc/presentation/journeys/loading/loading_screen.dart';
import 'package:movieapp_bloc/presentation/routes.dart';
import 'package:movieapp_bloc/presentation/themes/app_color.dart';
import 'package:movieapp_bloc/presentation/themes/theme_text.dart';
import 'package:movieapp_bloc/presentation/wiredash_app.dart';

class MovieApp extends StatefulWidget {
  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageCubit _languageCubit;
  late LoadingCubit _loadingCubit;
  late ThemeCubit _themeCubit;

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();

    _loadingCubit = getItInstance<LoadingCubit>();

    _themeCubit = getItInstance<ThemeCubit>();
    _themeCubit.loadPreferredTheme();
  }

  @override
  void dispose() {
    _languageCubit.close();
    _loadingCubit.close();
    _themeCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: _languageCubit),
        BlocProvider<LoadingCubit>.value(value: _loadingCubit),
        BlocProvider<ThemeCubit>.value(value: _themeCubit),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        builder: (context, theme) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              if (state is LanguageLoaded) {
                return WiredashApp(
                  navigatorKey: _navigatorKey,
                  languageCode: state.locale.languageCode,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: "Movie App",
                    navigatorKey: _navigatorKey,
                    theme: ThemeData(
                      primaryColor: theme == Themes.dark ? AppColor.vulcan : Colors.white,
                      scaffoldBackgroundColor: theme == Themes.dark ? AppColor.vulcan : Colors.white,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      textTheme: theme == Themes.dark ? ThemeText.getTextTheme() : ThemeText.getLightTextTheme(),
                      appBarTheme: const AppBarTheme(elevation: 0),
                      cardTheme: CardTheme(color: theme == Themes.dark ? Colors.white : AppColor.vulcan),
                        inputDecorationTheme: InputDecorationTheme(
                          hintStyle: Theme.of(context).textTheme.greySubtitle1,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme == Themes.dark
                                  ? Colors.white
                                  : AppColor.vulcan,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                      colorScheme: ColorScheme.fromSwatch().copyWith(
                        secondary: theme == Themes.dark ? AppColor.vulcan : Colors.white,
                        brightness: theme == Themes.dark ? Brightness.dark : Brightness.light,
                      ),
                    ),
                    locale: state.locale,
                    supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
                    // locale: Locale(Languages.languages[0].code),
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    builder: (context, child) {
                      return LoadingScreen(screen: child!);
                    },
                    // home: const HomeScreen(),
                    initialRoute: RouteList.initial,
                    onGenerateRoute: (RouteSettings settings) {
                      final routes = Routes.getRoutes(settings);
                      final WidgetBuilder? builder = routes[settings.name];
                      return FadePageRouteBuilder(
                        builder: builder!,
                        settings: settings,
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
