import 'dart:convert';

import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/net/ExceptionHandle.dart';
import 'package:app/net/base_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'intercept.dart';

/// 默认dio配置
int _connectTimeout = 15000;
int _receiveTimeout = 15000;
int _sendTimeout = 10000;
String _baseUrl = 'https://securecenter-poc.soulwallets.me';
List<Interceptor> _interceptors = [];

/// 初始化Dio配置
void configDio({
  int? connectTimeout,
  int? receiveTimeout,
  int? sendTimeout,
  String? baseUrl,
  List<Interceptor>? interceptors,
}) {
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}

typedef NetSuccessCallback<T> = Function(T data);
typedef NetSuccessListCallback<T> = Function(List<T> data);
typedef NetErrorCallback = Function(int code, String msg);

class DioUtils {
  factory DioUtils() => _singleton;

  DioUtils._() {
    final BaseOptions options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      // dio默认json解析，这里指定返回UTF8字符串，自己处理解析。（可也以自定义Transformer实现）
      responseType: ResponseType.plain,
      validateStatus: (_) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: _baseUrl,
//      contentType: Headers.formUrlEncodedContentType, // 适用于post form表单提交
    );
    _dio = Dio(options)..interceptors.add(AuthInterceptor());

    /// 添加拦截器
    void addInterceptor(Interceptor interceptor) {
      _dio.interceptors.add(interceptor);
    }

    _interceptors.forEach(addInterceptor);
  }

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  static const String _tag = '🌐 DioUtil';

  // 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _request<T>(
    String method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    LogUtil.d(
      'request：url: $url, data: $data, headers: ${options?.headers}',
      tag: _tag,
    );
    final Response<String> response = await _dio.request<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: _checkOptions(method, options),
      cancelToken: cancelToken,
    );
    try {
      final String data = response.data.toString();
      LogUtil.d('response：data: $data', tag: _tag);
      // 集成测试无法使用 isolate https://github.com/flutter/flutter/issues/24703
      // 使用 compute 条件：数据大于10KB（粗略使用10 * 1024）
      // 且当前不是集成测试（后面可能会根据Web环境进行调整）
      // 主要目的减少不必要的性能开销
      final bool isCompute = data.length > 10 * 1024;
      debugPrint('isCompute:$isCompute');
      final Map<String, dynamic> map =
          isCompute ? await compute(parseData, data) : parseData(data);
      return BaseEntity<T>.fromJson(map);
    } catch (e) {
      debugPrint(e.toString());
      return BaseEntity<T>(ExceptionHandle.parse_error, '数据解析错误！', null);
    }
  }

  Options _checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  Future<void> requestNetwork<T>(
    Method method,
    String url, {
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    return _request<T>(
      method.value,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ).then<void>((BaseEntity<T> result) {
      if (result.code == 200) {
        onSuccess?.call(result.data);
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (dynamic e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  /// 统一处理(onSuccess返回T对象，onSuccessList返回 List<T>)
  void asyncRequestNetwork<T>(
    Method method,
    String url, {
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    Stream.fromFuture(_request<T>(
      method.value,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    )).asBroadcastStream().listen((result) {
      if (result.code == 0) {
        if (onSuccess != null) {
          onSuccess(result.data);
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (dynamic e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  void _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      LogUtil.e('取消请求接口： $url', tag: _tag);
    }
  }

  void _onError(int? code, String msg, NetErrorCallback? onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知异常';
    }
    LogUtil.e('接口请求异常： code: $code, mag: $msg', tag: _tag);
    onError?.call(code, msg);
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

enum Method { get, post, put, patch, delete, head }

/// 使用拓展枚举替代 switch判断取值
/// https://zhuanlan.zhihu.com/p/98545689
extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
