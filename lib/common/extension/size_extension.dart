part of flutter_screenutil;

extension SizeExtension on num {
  double get w => ScreenUtil().setWidth(this).toDouble();

  double get h => ScreenUtil().setHeight(this).toDouble();

  double get sp => ScreenUtil().setSp(this).toDouble();
}
