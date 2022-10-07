import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/help_page/help_controller.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignTransactionBottomSheet extends GetCommonView<HelpController> {
  const SignTransactionBottomSheet({super.key});

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
              'Sign Transaction',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 9, right: 30),
            child: Text(
              'The process normally takes no more than 1 minute.',
              style: TextStyle(
                fontSize: 18,
                color: ColorStyle.color_black_80,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    decoration: const BoxDecoration(),
                    width: 112,
                    height: 60,
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorStyle.color_FF3940FF,
                        ),
                      ),
                    ),
                  ),
                  onTap: () => Get.back(),
                ),
                Button(
                  width: 200,
                  height: 60,
                  onPressed: () => onContinue(),
                  data: 'Continue',
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  onContinue() {
    Get.offAllNamed(Routes.homePage);
    ToastUtil.show("Transaction Signed");
  }
}
