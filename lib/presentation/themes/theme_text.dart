import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/presentation/themes/app_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _whiteHeadline6 => _poppinsTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteSubtitle1 => _poppinsTextTheme.subtitle1!.copyWith(fontSize: Sizes.dimen_16.sp, color: Colors.white);

  static TextStyle get _whiteBodyText2 => _poppinsTextTheme.bodyText2!.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get _whiteHeadline5 => _poppinsTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      );

  static TextStyle get whiteButton => _poppinsTextTheme.button!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );

  static getTextTheme() => TextTheme(
        headline6: _whiteHeadline6,
        subtitle1: _whiteSubtitle1,
        bodyText2: _whiteBodyText2,
        headline5: _whiteHeadline5,
        button: whiteButton,
      );

  static TextStyle? get _vulcanHeadline6 => _whiteHeadline6.copyWith(color: AppColor.vulcan);

  static TextStyle? get _vulcanHeadline5 => _whiteHeadline5.copyWith(color: AppColor.vulcan);

  static TextStyle? get vulcanSubtitle1 => _whiteSubtitle1.copyWith(color: AppColor.vulcan);

  static TextStyle? get vulcanBodyText2 => _whiteBodyText2.copyWith(color: AppColor.vulcan);

  static getLightTextTheme() => TextTheme(
        headline5: _vulcanHeadline5,
        headline6: _vulcanHeadline6,
        subtitle1: vulcanSubtitle1,
        bodyText2: vulcanBodyText2,
        button: whiteButton,
      );
}
