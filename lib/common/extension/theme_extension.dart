import 'package:flutter/material.dart';
import 'package:movieapp_bloc/presentation/themes/app_color.dart';

extension ThemeTextExtentions on TextTheme {
  TextStyle get royalBlueSubtitle1 => subtitle1!.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      );
}
