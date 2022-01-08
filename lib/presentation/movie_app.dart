import 'package:flutter/material.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/presentation/journeys/home/home_screen.dart';
import 'package:movieapp_bloc/presentation/themes/app_color.dart';
import 'package:movieapp_bloc/presentation/themes/theme_text.dart';

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movie App",
      theme: ThemeData(
        primaryColor: AppColor.vulcan,
        scaffoldBackgroundColor: AppColor.vulcan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      home: const HomeScreen(),
    );
  }
}
