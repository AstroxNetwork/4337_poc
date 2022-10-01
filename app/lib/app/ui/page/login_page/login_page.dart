import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/login_page/login_controller.dart';
import 'package:app/app/ui/page/login_page/widget/password_bottom_sheet.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetCommonView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 120),
          Image.asset(
            R.assetsImagesAppIconBig,
            width: 350,
            height: 318,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                width: 110,
                height: 61,
                onPressed: () => onLogIn(),
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
          const SizedBox(height: 63),
        ],
      ),
    );
  }

  onLogIn() {
    Get.bottomSheet(
      const PasswordBottomSheet(),
    );
  }

  onRecover() {
    Get.toNamed(Routes.recoverPage);
  }

  onCreate() {
    Get.toNamed(Routes.emailPage);
  }
}
