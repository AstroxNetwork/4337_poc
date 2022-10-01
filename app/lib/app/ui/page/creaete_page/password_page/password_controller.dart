import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends BaseGetController {
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController replacePasswordController =
      TextEditingController(text: '');

  onConfirm() {
    if (passwordController.text.isEmpty) {
      ToastUtil.show('Please enter new password');
      return;
    }

    if (replacePasswordController.text.isEmpty) {
      ToastUtil.show('Please confirm the password');
      return;
    }

    if (passwordController.text != replacePasswordController.text) {
      ToastUtil.show('Password not match');
    }

    // todo: createNewAddress
    Get.offAllNamed(Routes.homePage);
    // todo: cache
  }
}
