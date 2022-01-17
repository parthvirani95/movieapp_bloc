import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movieapp_bloc/common/constants/languages.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/di/get_it.dart';
import 'package:movieapp_bloc/presentation/app_localizations.dart';
import 'package:movieapp_bloc/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp_bloc/presentation/journeys/home/home_screen.dart';
import 'package:movieapp_bloc/presentation/themes/app_color.dart';
import 'package:movieapp_bloc/presentation/themes/theme_text.dart';

class MovieApp extends StatefulWidget {
  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageBloc _languageBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Movie App",
              theme: ThemeData(
                primaryColor: AppColor.vulcan,
                scaffoldBackgroundColor: AppColor.vulcan,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: ThemeText.getTextTheme(),
                accentColor: AppColor.royalBlue,
                appBarTheme: const AppBarTheme(elevation: 0),
              ),
              locale: state.locale,
              supportedLocales:
                  Languages.languages.map((e) => Locale(e.code)).toList(),
              // locale: Locale(Languages.languages[0].code),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home: const HomeScreen(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
