import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/email_validator.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/constant.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailController extends BaseGetController {
  RxInt countdown = 60.obs;
  RxBool isVerification = false.obs;

  late Timer timer;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController verfCodeController = TextEditingController(text: '');

  sendVerification() {
    if (!EmailValidator.validate(emailController.text)) {
      ToastUtil.show('Not a valid email address');
      return;
    }
    var params = Map();
    var emailStr = emailController.text;
    params['email'] = emailStr;
    requestNetwork<String>(Method.post,
        url: HttpApi.verifyEmail, params: params, onSuccess: (_) {
      isVerification.value = true;
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          countdown.value--;
          if (countdown.value == 0) {
            timer.cancel();
          }
        },
      );
    }, onError: (int code, String msg) {});
  }

  verification() {
    if (!EmailValidator.validate(emailController.text)) {
      ToastUtil.show('Not a valid email address');
      return;
    }
    if (!(verfCodeController.text.length == 6)) {
      ToastUtil.show('Not a valid verification code (6 digits)');
      return;
    }

    var emailStr = emailController.text;
    var params = Map();

    params['email'] = emailStr;
    params['code'] = verfCodeController.text;
    requestNetwork<Map<String, dynamic>>(
      Method.post,
      url: HttpApi.addAccount,
      params: params,
      onSuccess: (Map<String, dynamic>? res) {
        if (res != null) {
          // cache authorization
          if (res[Constant.jwtToken] != null) {
            Get.find<SharedPreferences>()
                .setString(Constant.accessToken, res[Constant.jwtToken]);
            var parameters = <String, String>{};
            parameters['email'] = emailStr;
            Get.toNamed(Routes.passwordPage, parameters: parameters);
          } else {
            ToastUtil.show('jwtToken error');
          }
        }
      },
    );
  }
}
