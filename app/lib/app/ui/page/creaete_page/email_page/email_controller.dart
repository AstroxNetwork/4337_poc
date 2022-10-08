import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/email_validator.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/constant.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailController extends BaseGetController {
  final emailTEC = TextEditingController();
  final verifyTEC = TextEditingController();
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
    final email = emailTEC.text;
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

  Future<void> recoverByEmail() async {
    final email = emailTEC.text, code = verifyTEC.text;
    if (!EmailValidator.validate(email)) {
      ToastUtil.show('Not a valid email address');
      return;
    }
    if (code.length != 6) {
      ToastUtil.show('Not a valid verification code (6 digits)');
      return;
    }
    loadingStart();
    WalletContext.createAccount();
    final address = await WalletContext.getWalletAddressByEmail(email);
    await requestNetwork<List>(
      Method.post,
      url: HttpApi.getAccountGuardian,
      params: {'wallet_address': address},
      onSuccess: (List? res) {
        if (res != null && res.isNotEmpty) {
          WalletContext.getInstance().setWalletAddress(address);
          Get.toNamed(
            Routes.recoverPage,
            arguments: {
              'email': email,
              'code': code,
              'guardians': res.cast<String>(),
            },
          );
        } else {
          ToastUtil.show('You have not guardians.');
        }
      },
    );
    loadingStop();
  }

  Future<void> loginByEmail() async {
    final email = emailTEC.text, code = verifyTEC.text;
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
            sp.setString(Constant.accessToken, res[Constant.jwtToken]);
            Get.toNamed(
              Routes.passwordPage,
              parameters: {'email': email},
            );
          } else {
            ToastUtil.show('Token error');
          }
        }
      },
    );
    loadingStop();
  }
}
