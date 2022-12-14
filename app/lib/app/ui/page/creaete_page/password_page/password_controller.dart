import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/app/wallet_sp.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends BaseGetController {
  final passwordController = TextEditingController();
  final replacePasswordController = TextEditingController();

  void onConfirm() {
    if (passwordController.text.isEmpty) {
      ToastUtil.show('Please enter new password');
      return;
    }
    if (replacePasswordController.text.isEmpty) {
      ToastUtil.show('Please enter the confirm password');
      return;
    }
    if (passwordController.text != replacePasswordController.text) {
      ToastUtil.show('Passwords not match');
    }
    createAccount(passwordController.text);
  }

  Future<void> createAccount(String password) async {
    final Map arguments = Map.from(Get.arguments ?? {});
    final email = arguments['email'];
    if (email == null) {
      ToastUtil.show('No email has been delivered.');
      return;
    }

    final shouldUpdateAccount = arguments['shouldUpdateAccount'] ?? true;
    loadingStart();
    if (shouldUpdateAccount) {
      WalletContext.createAccount();
      final walletJson = WalletContext.getInstance().toKeystore(password);
      await sp.setString(WalletSp.WALLET_JSON, walletJson);
      LogUtil.d("walletJson = $walletJson");
      final params = {
        'email': email,
        'wallet_address': WalletContext.getInstance().walletAddress.hex,
        'key': WalletContext.getInstance().account.address.hex,
      };
      await requestNetwork(
        Method.post,
        url: HttpApi.updateAccount,
        params: params,
        onSuccess: (data) {
          sp.setString(WalletSp.EMAIL, email);
          Get.offAllNamed(Routes.homePage);
        },
      );
    } else {
      final walletJson = WalletContext.getInstance().toKeystore(password);
      await sp.setString(WalletSp.WALLET_JSON, walletJson);
      LogUtil.d("walletJson = $walletJson");
      sp.setString(WalletSp.EMAIL, email);
      Get.offAllNamed(Routes.homePage);
    }
    loadingStop();
  }
}
