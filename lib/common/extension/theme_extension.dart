import 'package:flutter/material.dart';
import 'package:movieapp_bloc/presentation/themes/app_color.dart';

extension ThemeTextExtentions on TextTheme {
  TextStyle get royalBlueSubtitle1 => subtitle1!.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      );

  TextStyle get greySubtitle1 => subtitle1!.copyWith(
        color: Colors.grey,
      );

  TextStyle get violetHeadline6 => headline6!.copyWith(
        color: AppColor.violet,
      );

  TextStyle get vulcanBodyText2 => bodyText2!.copyWith(
        color: AppColor.vulcan,
        fontWeight: FontWeight.w600,
      );
}
