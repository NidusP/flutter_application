import 'package:flutter_application/common/values/values.dart';
import 'package:localstorage/localstorage.dart';

/// 本地存储
/// 单例 StorageUtil().getItem('key')
class StorageUtil {
  static final StorageUtil _singleton = StorageUtil._internal();
  late LocalStorage _storage;

  factory StorageUtil() {
    return _singleton;
  }

  StorageUtil._internal() {
    _storage = LocalStorage(storageMasterKey);
  }


  String getItem(String key) {
    var val = _storage.getItem(key);
    return val ?? '';
  }

  Future<void> setItem(String key, String val) async {
    await _storage.setItem(key, val);
  }
}
