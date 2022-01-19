import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _whiteHeadline6 => _poppinsTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle get whiteSubtitle1 => _poppinsTextTheme.subtitle1!.copyWith(fontSize: Sizes.dimen_16.sp, color: Colors.white);

  static TextStyle get whiteBodyText2 => _poppinsTextTheme.bodyText2!.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get whiteHeadline5 => _poppinsTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      );

  static TextStyle get whiteButton => _poppinsTextTheme.button!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );

  static getTextTheme() => TextTheme(
        headline6: _whiteHeadline6,
        subtitle1: whiteSubtitle1,
        bodyText2: whiteBodyText2,
        headline5: whiteHeadline5,
        button: whiteButton,
      );
}
