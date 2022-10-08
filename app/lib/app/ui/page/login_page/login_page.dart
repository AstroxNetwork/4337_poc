import 'dart:convert';

import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/creaete_page/email_page/email_binding.dart';
import 'package:app/app/ui/page/creaete_page/email_page/email_controller.dart';
import 'package:app/app/ui/page/creaete_page/email_page/email_page.dart';
import 'package:app/app/ui/page/login_page/login_controller.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/trademark_widget.dart';
import 'package:app/app/util/email_validator.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/constant.dart';
import 'package:app/eip4337lib/backend/request.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends GetCommonView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 120),
          GestureDetector(
            onTap: () => controller.jumpDebugPage(),
            onLongPress: () => Get.toNamed(
              Routes.transactionPage,
              arguments: {
                'email': 'web2@alexv525.com',
                'code': '888888',
                'new_key': '0xbaf8653f1a89abd5d0bac763099cfde0a991410b',
                'request_id':
                    '0xd6cc43163d734586a05c74cab7dee81811adb988f2281ce977e6b0a6a7caf5ef',
                'selected': [
                  '0x7AB74728edb19acE6347E8FE678138e383A664A2',
                  '0xeC9a6761a181C942906919Cc73C38de96C6FdFBD',
                ],
              },
            ),
            child: Image.asset(
              R.ASSETS_IMAGES_APP_ICON_BIG_PNG,
              width: 350,
              height: 318,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                width: 110,
                height: 61,
                onPressed: () => controller.onLogin(),
                data: 'Log in',
                color: Colors.white,
                borderWidth: 1,
                fontColor: ColorStyle.color_FF3940FF,
              ),
              const SizedBox(width: 10),
              Button(
                width: 210,
                height: 61,
                onPressed: () => onCreate(),
                data: 'Create New Wallet',
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () => onRecover(),
            child: const Text(
              'Recover A Wallet',
              style: TextStyle(
                color: ColorStyle.color_FF3940FF,
                fontSize: 20,
                letterSpacing: -0.48,
              ),
            ),
          ),
          const SizedBox(height: 50),
          TradeMarkWidget(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Future<void> _recoverByEmail(EmailController c) async {
    final email = c.emailTEC.text, code = c.verifyTEC.text;
    if (!EmailValidator.validate(email)) {
      ToastUtil.show('Not a valid email address');
      return;
    }
    if (code.length != 6) {
      ToastUtil.show('Not a valid verification code (6 digits)');
      return;
    }
    c.loadingStart();
    WalletContext.createAccount();
    final address =
        await WalletContext.getInstance().getWalletAddressByEmail(email);
    await c.requestNetwork<List>(
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
    c.loadingStop();
  }

  Future<void> _loginByEmail(EmailController c) async {
    final email = c.emailTEC.text, code = c.verifyTEC.text;
    if (!EmailValidator.validate(email)) {
      ToastUtil.show('Not a valid email address');
      return;
    }
    if (code.length != 6) {
      ToastUtil.show('Not a valid verification code (6 digits)');
      return;
    }
    c.loadingStart();
    await c.requestNetwork<Map>(
      Method.post,
      url: HttpApi.addAccount,
      params: {'email': email, 'code': code},
      onSuccess: (Map? res) {
        if (res != null) {
          // cache authorization
          if (res[Constant.jwtToken] != null) {
            Get.find<SharedPreferences>().setString(
              Constant.accessToken,
              res[Constant.jwtToken],
            );
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
    c.loadingStop();
  }

  void onRecover() {
    Get.to(
      () => EmailPage(onConfirm: _recoverByEmail),
      binding: EmailBinding(),
    );
  }

  void onCreate() {
    Get.to(
      () => EmailPage(onConfirm: _loginByEmail),
      binding: EmailBinding(),
    );
  }
}
