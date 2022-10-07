import 'dart:convert';

import 'package:app/constant.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? accessToken = Get.find<SharedPreferences>().getString(Constant.accessToken);
    LogUtil.d('AuthInterceptor accessToken = $accessToken');
    if (accessToken != null) {
      options.headers[Constant.accessToken] = 'bearer $accessToken';
    }
    super.onRequest(options, handler);
  }
}