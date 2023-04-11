import 'package:flutter/material.dart';
import 'package:flutter_application/common/utils/utils.dart';
import 'package:flutter_application/common/values/values.dart';

Widget btnFlatButtonWidget(
    {required VoidCallback onPressed,
    Color gbColor = AppColors.primaryElement,
    Color fontColor = AppColors.secondaryElement,
    String fontFamily = AppFonts.secondaryFamily,
    FontWeight fontWeight = FontWeight.w400,
    String title = 'button',
    double fontSize = 18,
    double width = 140,
    double height = 44}) {
  return SizedBox(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: MaterialButton(
      onPressed: onPressed,
      color: gbColor,
      shape: const RoundedRectangleBorder(borderRadius: Radii.k6pxRadius),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          fontSize: duSetFontSize(fontSize),
          height: 1,
        ),
      ),
    ),
  );
}

/// 第三方按钮
Widget btnFlatButtonBorderOnlyWidget(
    {required VoidCallback onPressed,
    double width = 88,
    double height = 44,
    required String iconFileName}) {
  return SizedBox(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
          side: Borders.priamryBorder, borderRadius: Radii.k6pxRadius),
      child: Image.asset("assets/images/icons-$iconFileName.png"),
    ),
  );
}
