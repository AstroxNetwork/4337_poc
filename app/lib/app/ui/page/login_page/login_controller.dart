import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/page/login_page/widget/password_bottom_sheet.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/app/wallet_sp.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/helper.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseGetController {
  final bool showPasswordsImmediately =
      Get.arguments?['showPasswordsImmediately'] ?? true;
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
    if (showPasswordsImmediately && sp.getString(WalletSp.EMAIL) != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onLogin();
      });
    }
  }

  void onLogin() {
    final email = sp.getString(WalletSp.EMAIL);
    final walletJson = sp.getString(WalletSp.WALLET_JSON);
    if (email == null ||
        email.isEmpty ||
        walletJson == null ||
        walletJson.isEmpty) {
      ToastUtil.show('no wallet yet');
      return;
    }
    Get.bottomSheet(
      PasswordBottomSheet(onLogin: () {
        confirm(email, passwordController.text, walletJson);
      }),
      isScrollControlled: true,
    );
  }

  void confirm(String email, String password, String walletJson) {
    loadingStart();
    try {
      WalletContext.recoverKeystore(Web3Helper.client, walletJson, password);
      final address = sp.getString(WalletSp.WALLET_ADDRESS);
      if (address != null) {
        WalletContext.getInstance().setWalletAddress(address);
      }
      Get.offAllNamed(Routes.homePage);
    } on ArgumentError catch (e, s) {
      LogUtil.w(e, stackTrace: s);
      ToastUtil.show(e.message.toString());
    } catch (e) {
      LogUtil.d('err = $e');
      ToastUtil.show(e.toString());
    }
    loadingStop();
  }

  void jumpDebugPage() {
    Get.toNamed(Routes.debugPage);
  }
}
