import 'package:flutter/material.dart';
import 'package:flutter_application/common/entities/entities.dart';
import 'package:flutter_application/common/utils/utils.dart';
import 'package:flutter_application/common/values/values.dart';

Widget newsCategoriesWidget(
    {List<CategoryResponseEntity>? categories,
    String? selCategoryCode,
    required Function(CategoryResponseEntity) onTap}) {
  return categories == null
      ? Container()
      : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map<Widget>((item) {
              return Container(
                alignment: Alignment.center,
                height: duSetHeight(52),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: selCategoryCode == item.code
                          ? AppColors.secondaryElementText
                          : AppColors.primaryText,
                      fontSize: duSetFontSize(18),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // onTap: () => onTap(item),
                ),
              );
            }).toList(),
          ),
        );
}
