import 'package:flutter/material.dart';
import 'package:flutter_application/common/utils/utils.dart';

import 'common/entities/entities.dart';

class Global {
  static UserResponseEntity profile = UserResponseEntity(accessToken: null);

  /// 是否 Release
  static bool get isRelease => const bool.fromEnvironment('dart.vm.product');

  static init() async {
    WidgetsFlutterBinding.ensureInitialized();


    StorageUtil();
    HttpUtil();


    // StorageUtil().ge
  }
}