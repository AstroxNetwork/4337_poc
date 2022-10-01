import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/email_validator.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/net/http_api.dart';
import 'package:app/net/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    params['email'] = emailController.text;

    // todo: cache email
    HttpUtils.instance.requestPost<Null>(HttpApi.verifyEmail, params: params,
        onSuccess: (_) {
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
    /// Skyh
    // var params = Map();
    // params['email'] = 'skyhighfeng@gmail.com';
    // final response = await Request.verifyEmail(params);

    if (!EmailValidator.validate(emailController.text)) {
      ToastUtil.show('Not a valid email address');
      return;
    }

    if (!(verfCodeController.text.length == 6)) {
      ToastUtil.show('Not a valid verification code (6 digits)');
      return;
    }

    /// Skyh
    // var params = Map();
    // params['email'] = 'skyhighfeng@gmail.com';
    // params['code'] = '198GFG';
    // final response = await Request.addAccount(params);
    // {"code":400,"msg":"Code is not valid.","data":{}}
    // {"code":200,"msg":"Add record successfully.","data":{"jwtToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNreWhpZ2hmZW5nQGdtYWlsLmNvbSIsImlhdCI6MTY2NDQ1ODgzOSwiZXhwIjoxNjY1NzU0ODM5fQ.QssiBtGElqIwuzSIaZJyRW8Jyw_iNQmDFQaEOdm2Bmg"}}

    var params = Map();
    params['email'] = emailController.text;
    params['code'] = verfCodeController.text;
    HttpUtils.instance.requestPost<String>(
      HttpApi.addAccount,
      params: params,
      onSuccess: (String? res) {
        if (res != null) {
          // todo : cache authorization
          Get.toNamed(Routes.passwordPage);
        }
      },
    );
  }
}
