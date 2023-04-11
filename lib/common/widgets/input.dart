import 'package:flutter/material.dart';
import 'package:flutter_application/common/utils/screen.dart';
import 'package:flutter_application/common/values/values.dart';

Widget inputTextEdit(
    {required TextEditingController controller,
    FocusNode? focusNode,
    TextInputType keyboardType = TextInputType.text,
    String hintText = '',
    double marginTop = 15,
    bool isPassword = false}) {
  return Container(
    height: duSetHeight(44),
    margin: EdgeInsets.only(top: duSetHeight(marginTop)),
    decoration: const BoxDecoration(
        borderRadius: Radii.k6pxRadius, color: AppColors.secondaryElement),
    child: TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 10)),
      style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: AppFonts.secondaryFamily,
          fontSize: duSetFontSize(18),
          fontWeight: FontWeight.w400),
      maxLines: 1,
      autocorrect: false, // 自动纠正
      obscureText: isPassword,
    ),
  );
}
