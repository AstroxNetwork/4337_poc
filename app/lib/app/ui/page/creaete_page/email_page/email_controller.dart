import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/util/email_validator.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
