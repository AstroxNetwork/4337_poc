import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailController extends BaseGetController {
  RxInt countdown = 60.obs;
  RxBool isVerification = false.obs;

  late Timer timer;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController verfCodeController = TextEditingController(text: '');

  sendVerification() {
    if (emailController.text.isEmpty) {
      // todo: 输入为空
      ToastUtil.show('input is empty');
    } else {
      // todo: 发送验证码到邮箱
      isVerification.value = true;
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          countdown.value--;
          if (countdown.value == 0) {
            timer.cancel();
          }
          // update();
        },
      );
      // update();
    }
  }

  verification() {
    if (verfCodeController.text.isEmpty) {
      // todo: 输入为空
      ToastUtil.show('input is empty');
    } else {
      // todo: 校验验证码 success回调为跳转到password页面
      Get.toNamed(Routes.passwordPage);
    }
  }
}
