import 'package:flutter_screenutil/flutter_screenutil.dart';

double duSetWidth(double width){
  return ScreenUtil().setWidth(width);
}

double duSetHeight(double h){
  return ScreenUtil().setHeight(h);
}

double duSetFontSize(double size){
  return ScreenUtil().setSp(size);
}