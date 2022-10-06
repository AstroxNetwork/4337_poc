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

  onLogin() {
    var email = Get.find<SharedPreferences>().getString(WalletSp.EMAIL);
    var walletJson = Get.find<SharedPreferences>().getString(WalletSp.WALLET_JSON);
    if (email == null || email.isEmpty || walletJson == null || walletJson.isEmpty) {
      ToastUtil.show('no wallet yet');
      return;
    }
    Get.bottomSheet(PasswordBottomSheet(onLogin: () {
      confrim(email, passwordController.text, walletJson);
    }));
  }

  confrim(String email, String password, String walletJson) {
    isLoading.value = true;
    Future(() {
      WalletContext.recoverKeystore(Web3Helper.web3(), walletJson, password);
      WalletContext.getInstance().setWalletAddressAutomatic();
    }).then((_) {
      Get.offAllNamed(Routes.homePage);
      isLoading.value = false;
    }).catchError((err) {
      isLoading.value = false;
      print('err = $err');
      ToastUtil.show(err.toString());
    });
  }

  jumpDebugPage() {
    Get.toNamed(Routes.debugPage);
  }
}
