import 'dart:async';

import 'package:hive/hive.dart';
import 'package:movieapp_bloc/common/constants/theme.dart';

abstract class ThemeLocalDataSource {
  Future<void> updateTheme(Themes? themes);
  Future<Themes> getPreferredTheme();
}

class ThemeLocalDataSourceImpl extends ThemeLocalDataSource {
  @override
  Future<Themes> getPreferredTheme() async {
    final theme = await Hive.openBox('themeBox');
    return theme.get('appTheme', defaultValue: 'dark') == 'dark' ? Themes.dark : Themes.light;
  }

  @override
  Future<void> updateTheme(Themes? themes) async {
    final themeBox = await Hive.openBox("themeBox");
    unawaited(themeBox.put('appTheme', (themes ?? Themes.dark) == Themes.dark ? 'dark' : 'light'));
  }
}
