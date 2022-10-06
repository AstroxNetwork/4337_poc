import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/login_page/login_controller.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PasswordBottomSheet extends GetCommonView<LoginController> {
  final VoidCallback onLogin;
  PasswordBottomSheet({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 390,
      decoration: BoxDecoration(
        color: appThemeData.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              'Enter Password to log in',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 59),
            child: Edit(
              controller: controller.passwordController,
              width: 322,
              height: 55,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorStyle.color_FF3940FF,
                    ),
                  ),
                  onTap: () => Get.back(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Button(
                    width: 200,
                    height: 60,
                    onPressed: onLogin,
                    data: 'Confirm',
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
