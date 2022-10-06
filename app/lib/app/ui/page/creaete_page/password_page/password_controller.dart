import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/app/wallet_sp.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/helper.dart';
import 'package:app/eip4337lib/utils/log_utils.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    createAccount(passwordController.text);
  }

  Future createAccount(String password) async {
    isLoading.value = true;
    Future(() {
      WalletContext.createAccount(Web3Helper.web3());
      var walletJson = WalletContext.getInstance().toKeystore(password);
      Get.find<SharedPreferences>().setString(WalletSp.WALLET_JSON, walletJson);
      Log.d("walletJson = $walletJson");
      WalletContext.getInstance().setWalletAddressAutomatic();
    }).then((_) {
      var address = WalletContext.getInstance().walletAddress?.hexNo0x;
      var params = Map();
      var email = Get.parameters['email'] as String?;
      if (email != null) {
        params['email'] = email;
        params['wallet_address'] = address;
        params['key'] = WalletContext.getInstance().getEoaAddress();
        return requestNetwork(Method.post, url: HttpApi.updateAccount, params: params, onSuccess: (data) {
          isLoading.value = false;
          Get.find<SharedPreferences>().setString(WalletSp.EMAIL, email);
          Get.offAllNamed(Routes.homePage);
        }, onError: (_, _2){
          isLoading.value = false;
        });
      }
    });
  }
}
