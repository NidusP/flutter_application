import 'dart:async';
// import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_application/common/utils/utils.dart';
import 'package:flutter_application/common/values/values.dart';
import 'package:flutter_application/global.dart';

/*
  * http 操作类
  *
  * 手册
  * https://github.com/flutterchina/dio/blob/master/README-ZH.md#formdata
  *
  * 从2.1.x升级到 3.x
  * https://github.com/flutterchina/dio/blob/master/migration_to_3.0.md
*/
class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: serverApiUrl,

      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: const Duration(seconds: 10000),

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: const Duration(seconds: 5000),

      // Http请求头.
      headers: {},

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    // Cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    // 添加拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioError` using `handler.reject(dioError)`.
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object using `handler.reject(dioError)`.
          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          return handler.next(e);
        },
      ),
    );

    // 加内存缓存
    dio.interceptors.add(NetCache());

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!Global.isRelease && proxyEnable) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        onHttpClientCreate: (client) {
          client.findProxy = (uri) {
            // 将请求代理至 localhost:8888。
            // 请注意，代理会在你正在运行应用的设备上生效，而不是在宿主平台生效。
            return "PROXY $proxyIp:$proxyPort";
          };
          return client;
        },
      );
      // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //     (client) {
      //   client.findProxy = (uri) {
      //     return "PROXY $proxyIp:$proxyPort";
      //   };
      //   //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
      //   client.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) => true;
      // };
    }
  }

  /*
   * error统一处理
   */
  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
      case DioErrorType.connectionTimeout:
        {
          return ErrorEntity(code: -1, message: "连接超时");
        }
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }
      case DioErrorType.badResponse:
        {
          try {
            int? errCode = error.response?.statusCode;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                {
                  return ErrorEntity(code: 400, message: "请求语法错误");
                }
              case 401:
                {
                  return ErrorEntity(code: 401, message: "没有权限");
                }
              case 403:
                {
                  return ErrorEntity(code: 403, message: "服务器拒绝执行");
                }
              case 404:
                {
                  return ErrorEntity(code: 404, message: "无法连接服务器");
                }
              case 405:
                {
                  return ErrorEntity(code: 405, message: "请求方法被禁止");
                }
              case 500:
                {
                  return ErrorEntity(code: 500, message: "服务器内部错误");
                }
              case 502:
                {
                  return ErrorEntity(code: 502, message: "无效的请求");
                }
              case 503:
                {
                  return ErrorEntity(code: 503, message: "服务器挂了");
                }
              case 505:
                {
                  return ErrorEntity(code: 505, message: "不支持HTTP协议请求");
                }
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ErrorEntity(
                      code: errCode, message: error.response?.statusMessage);
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /// 读取本地配置
  Map<String, dynamic> getAuthorizationHeader() {
    Map<String, String> headers = {};
    String? accessToken = Global.profile.accessToken;
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  void _mergeAuthorizationHeader(
      Map<String, dynamic>? authorization, Options requestOptions) {
    if (authorization != null && authorization['Authorization'] != null) {
      requestOptions.headers = authorization;
    }
  }

  /// restful get 操作
  /// refresh 是否下拉刷新 默认 false
  /// noCache 是否不缓存 默认 true
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  Future get(
    String path, {
    dynamic params,
    Options? options,
    bool refresh = false,
    bool noCache = !cacheEnable,
    bool list = false,
    String? cacheKey,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      // requestOptions = requestOptions.merge(extra: {
      //   "refresh": refresh,
      //   "noCache": noCache,
      //   "list": list,
      //   "cacheKey": cacheKey,
      // });
      requestOptions.extra = {
        "refresh": refresh,
        "noCache": noCache,
        "list": list,
        "cacheKey": cacheKey,
      };
      // _mergeAuthorizationHeader(getAuthorizationHeader(), requestOptions);
      // Map<String, dynamic> authorization = getAuthorizationHeader();
      // if (authorization != null) {
      //   // requestOptions = requestOptions.merge(headers: authorization);
      // }

      var response = await dio.get(path,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful post 操作
  Future post(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    _mergeAuthorizationHeader(getAuthorizationHeader(), requestOptions);

    var response = await dio.post(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful put 操作
  Future put(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    _mergeAuthorizationHeader(getAuthorizationHeader(), requestOptions);
    var response = await dio.put(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful patch 操作
  Future patch(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    _mergeAuthorizationHeader(getAuthorizationHeader(), requestOptions);
    var response = await dio.patch(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    _mergeAuthorizationHeader(getAuthorizationHeader(), requestOptions);
    var response = await dio.delete(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    _mergeAuthorizationHeader(getAuthorizationHeader(), requestOptions);
    var response = await dio.post(path,
        data: FormData.fromMap(params),
        options: requestOptions,
        cancelToken: cancelToken);
    return response.data;
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int? code;
  String? message;
  ErrorEntity({this.code, this.message});

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
