import 'package:flutter_application/common/utils/utils.dart';
import 'package:flutter_application/common/entities/entities.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserLoginResponseEntity> login({required UserLoginRequestEntity params}) async {
    var response = await HttpUtil().post('/user/login', params: params.toJson());
    return UserLoginResponseEntity.fromJson(response);
  }
}
