import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_bloc/common/constants/languages.dart';
import 'package:movieapp_bloc/common/constants/route_constants.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/constants/theme.dart';
import 'package:movieapp_bloc/common/constants/translation_constants.dart';
import 'package:movieapp_bloc/common/extension/string_extension.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/presentation/app_dialog.dart';
import 'package:movieapp_bloc/presentation/cubit/language/language_cubit.dart';
import 'package:movieapp_bloc/presentation/cubit/themes/theme_cubit.dart';
import 'package:movieapp_bloc/presentation/journeys/drawer/navigation_expanded_list_item.dart';
import 'package:movieapp_bloc/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:movieapp_bloc/presentation/themes/app_color.dart';
import 'package:movieapp_bloc/presentation/widgets/logo.dart';
import 'package:wiredash/wiredash.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.dimen_300.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.h,
              ),
              child: Logo(height: Sizes.dimen_20.h),
            ),
            NavigationListItem(
              title: TranslationConstants.favoriteMovies.translate(context),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.favorite);
              },
            ),
            NavigationExpandedListItem(
              title: TranslationConstants.language.translate(context),
              children: Languages.languages.map((e) => e.value).toList(),
              onPressed: (index) {
                BlocProvider.of<LanguageCubit>(context).toggleLanguage(Languages.languages[index]);
              },
            ),

            // NavigationExpandedListItem(
            //   title: TranslationConstants.theme.translate(context),
            //   children: ThemesList.themeList.map((e) => e.key).toList(),
            //   onPressed: (index) {
            //     BlocProvider.of<ThemeCubit>(context).toggleTheme(ThemesList.themeList[index].theme);
            //   },
            // ),
            NavigationListItem(
              title: TranslationConstants.feedback.translate(context),
              onPressed: () {
                Navigator.of(context).pop();
                Wiredash.of(context)!.show();
              },
            ),
            NavigationListItem(
              title: TranslationConstants.about.translate(context),
              onPressed: () {
                Navigator.of(context).pop();
                _showDialog(context);
              },
            ),
            BlocBuilder<ThemeCubit, Themes>(builder: (context, theme) {
              return Align(
                alignment: Alignment.center,
                child: IconButton(
                  //2
                  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                  icon: Icon(
                    //3
                    theme == Themes.dark ? Icons.brightness_4_sharp : Icons.brightness_7_sharp,
                    color: context.read<ThemeCubit>().state == Themes.dark ? Colors.white : AppColor.vulcan,
                    size: Sizes.dimen_40.w,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AppDialog(
          title: TranslationConstants.about,
          description: TranslationConstants.aboutDescription,
          buttonText: TranslationConstants.okay,
          image: Image.asset(
            'assets/pngs/tmdb_logo.png',
            height: Sizes.dimen_32.h,
          ),
        );
      },
    );
  }
}
