import 'package:flutter/material.dart';
import 'package:flutter_application/common/values/colors.dart';

PreferredSizeWidget transparentAppBar(
    {required BuildContext context,
    Widget? title,
    Widget? leading,
    List<Widget>? actions}) {
  leading ??= IconButton(
    icon: const Icon(
      Icons.arrow_back,
      color: AppColors.primaryText,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  
  return AppBar(
    backgroundColor: const Color.fromARGB(0, 0, 0, 0),
    // elevation: 0,
    actions: actions,
    title: title,
    leading: leading,
  );
}
