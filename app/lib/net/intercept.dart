import 'dart:convert';

import 'package:app/constant.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? accessToken = Get.find<SharedPreferences>().getString(Constant.accessToken);
    if (accessToken != null) {
      options.headers[Constant.accessToken] = '$accessToken';
    }
    super.onRequest(options, handler);
  }
}