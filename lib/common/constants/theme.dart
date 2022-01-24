import 'package:movieapp_bloc/domain/entities/theme_entity.dart';

enum Themes { light, dark }

class ThemesList {
  const ThemesList._();

  static const themeList = [
    ThemeEntity(key: "Light", theme: Themes.light),
    ThemeEntity(key: "Dark", theme: Themes.dark),
  ];
}
