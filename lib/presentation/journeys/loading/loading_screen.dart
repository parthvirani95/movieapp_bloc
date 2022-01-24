import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/presentation/cubit/loading/loading_cubit.dart';
import 'package:movieapp_bloc/presentation/journeys/loading/loading_circle.dart';
import 'package:movieapp_bloc/presentation/themes/app_color.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;

  const LoadingScreen({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(builder: (context, shouldShow) {
      return Stack(
        fit: StackFit.expand,
        children: [
          screen,
          if (shouldShow)
            Container(
              decoration: BoxDecoration(color: AppColor.vulcan.withOpacity(0.8)),
              child: Center(
                child: LoadingCircle(size: Sizes.dimen_200.w),
              ),
            )
        ],
      );
    });
  }
}
