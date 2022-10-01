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
    if (passwordController.text.isEmpty ||
        replacePasswordController.text.isEmpty) {
      // todo: 输入为空
      ToastUtil.show('input is empty');
    } else if (passwordController.text != replacePasswordController.text) {
      // todo: 输入错误
      ToastUtil.show('input is error');
    } else {
      // todo: 注册账号 success回调为跳转到home页面
      Get.offAllNamed(Routes.homePage);
    }
  }
}
