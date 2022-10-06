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
  final emailController = TextEditingController();
  final verifyController = TextEditingController();
  final verifyFocusNode = FocusNode();
  final RxInt countdown = 60.obs;
  final RxBool isVerification = false.obs;
  Timer? timer;

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }

  Future<void> sendVerification() async {
    final email = emailController.text;
    if (!EmailValidator.validate(email)) {
      ToastUtil.show('Not a valid email address');
      return;
    }
    loadingStart();
    await requestNetwork<String>(
      Method.post,
      url: HttpApi.verifyEmail,
      params: {'email': email},
      onSuccess: (_) {
        countdown.value = 60;
        isVerification.value = true;
        verifyFocusNode.requestFocus();
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          countdown.value--;
          if (countdown.value == 0) {
            timer.cancel();
          }
        });
      },
      onError: (int code, String msg) {},
    );
    loadingStop();
  }

  Future<void> verifyCode() async {
    final email = emailController.text, code = verifyController.text;
    if (!EmailValidator.validate(email)) {
      ToastUtil.show('Not a valid email address');
      return;
    }
    if (code.length != 6) {
      ToastUtil.show('Not a valid verification code (6 digits)');
      return;
    }
    loadingStart();
    await requestNetwork<Map>(
      Method.post,
      url: HttpApi.addAccount,
      params: {'email': email, 'code': code},
      onSuccess: (Map? res) {
        if (res != null) {
          // cache authorization
          if (res[Constant.jwtToken] != null) {
            Get.find<SharedPreferences>().setString(
              Constant.accessToken,
              res[Constant.jwtToken],
            );
            Get.toNamed(Routes.passwordPage, parameters: {'email': email});
          } else {
            ToastUtil.show('jwtToken error');
          }
        }
      },
    );
    loadingStop();
  }
}
