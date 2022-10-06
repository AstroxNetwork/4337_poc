import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/page/login_page/widget/password_bottom_sheet.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/app/wallet_sp.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends BaseGetController {
  TextEditingController passwordController = TextEditingController(text: '');

  void onLogin() {
    final sp = Get.find<SharedPreferences>();
    final email = sp.getString(WalletSp.EMAIL);
    final walletJson = sp.getString(WalletSp.WALLET_JSON);
    if (email == null ||
        email.isEmpty ||
        walletJson == null ||
        walletJson.isEmpty) {
      ToastUtil.show('no wallet yet');
      return;
    }
    Get.bottomSheet(PasswordBottomSheet(onLogin: () {
      confirm(email, passwordController.text, walletJson);
    }));
  }

  void confirm(String email, String password, String walletJson) {
    isLoading.value = true;
    try {
      WalletContext.recoverKeystore(Web3Helper.client, walletJson, password);
      WalletContext.getInstance().setWalletAddressAutomatic();
      Get.offAllNamed(Routes.homePage);
    } catch (e) {
      print('err = $e');
      ToastUtil.show(e.toString());
    }
    isLoading.value = false;
  }

  void jumpDebugPage() {
    Get.toNamed(Routes.debugPage);
  }
}
