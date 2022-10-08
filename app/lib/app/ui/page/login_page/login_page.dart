import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/creaete_page/email_page/email_binding.dart';
import 'package:app/app/ui/page/creaete_page/email_page/email_page.dart';
import 'package:app/app/ui/page/login_page/login_controller.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/trademark_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            onLongPress: kDebugMode ? () => controller.jumpDebugPage() : null,
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
          const TradeMarkWidget(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  void onRecover() {
    Get.to(
      () => EmailPage(onConfirm: (c) => c.recoverByEmail()),
      binding: EmailBinding(),
    );
  }

  void onCreate() {
    Get.to(
      () => EmailPage(onConfirm: (c) => c.loginByEmail()),
      binding: EmailBinding(),
    );
  }
}
