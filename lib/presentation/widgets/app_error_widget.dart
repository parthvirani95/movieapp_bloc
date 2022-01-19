import 'package:flutter/material.dart';
import 'package:movieapp_bloc/common/constants/size_constants.dart';
import 'package:movieapp_bloc/common/constants/translation_constants.dart';
import 'package:movieapp_bloc/common/extension/string_extension.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/presentation/widgets/button.dart';
import 'package:wiredash/wiredash.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final Function onPressed;

  const AppErrorWidget({
    Key? key,
    required this.errorType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorType == AppErrorType.api
                ? TranslationConstants.somethingWentWrong.translate(context)
                : TranslationConstants.checkNetwork.translate(context),
          ),
          ButtonBar(
            children: [
              Button(text: TranslationConstants.retry, onPressed: () => onPressed),
              Button(text: TranslationConstants.feedback, onPressed: () => Wiredash.of(context)?.show()),
            ],
          )
        ],
      ),
    );
  }
}
