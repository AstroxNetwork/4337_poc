import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/creaete_page/email_page/email_binding.dart';
import 'package:app/app/ui/page/creaete_page/email_page/email_page.dart';
import 'package:app/app/ui/page/login_page/login_controller.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/util/email_validator.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/constant.dart';
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
          const SizedBox(height: 63),
        ],
      ),
    );
  }

  void onRecover() {
    Get.to(
      () => EmailPage(
        onConfirm: (c) async {
          final email = c.emailController.text, code = c.verifyController.text;
          if (!EmailValidator.validate(email)) {
            ToastUtil.show('Not a valid email address');
            return;
          }
          if (code.length != 6) {
            ToastUtil.show('Not a valid verification code (6 digits)');
            return;
          }
          c.loadingStart();
          await c.requestNetwork<List>(
            Method.post,
            url: HttpApi.getAccountGuardian,
            onSuccess: (List? res) {
              if (res != null && res.isNotEmpty) {
                Get.toNamed(Routes.recoverPage);
              } else {
                ToastUtil.show('You have not guardians.');
              }
            },
          );
          c.loadingStop();
        },
      ),
      binding: EmailBinding(),
    );
  }

  void onCreate() {
    Get.to(
      () => EmailPage(
        onConfirm: (c) async {
          final email = c.emailController.text, code = c.verifyController.text;
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
        },
      ),
      binding: EmailBinding(),
    );
  }
}
