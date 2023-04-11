import 'package:flutter/material.dart';
import 'package:flutter_application/common/values/colors.dart';

AppBar transparentAppBar(
    {required BuildContext context, List<Widget>? actions}) {
  return AppBar(
    backgroundColor: const Color.fromARGB(0, 0, 0, 0),
    // elevation: 0,
    actions: actions,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.primaryText,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
