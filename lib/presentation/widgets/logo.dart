import 'package:flutter/material.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  final double height;

  const Logo({Key? key, required this.height})
      : assert(height > 0, 'Height should be greated than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pngs/logo.png',
      color: Colors.white,
      height: height.h,
    );
  }
}
