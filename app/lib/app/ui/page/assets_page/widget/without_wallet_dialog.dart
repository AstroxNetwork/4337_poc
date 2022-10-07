import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/widget/dialog_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithoutWalletDialog extends GetCommonView<AssetsController> {
  const WithoutWalletDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Container(
        width: 330,
        height: 200,
        decoration: BoxDecoration(
          color: appThemeData.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 29, right: 25),
              child: Text(
                'There’s not enough fund in the wallet. You can receive some from your friends.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 165,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: ColorStyle.color_4D979797,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Not now',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      controller.onReceiveClick();
                    },
                    child: Container(
                      width: 165,
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 1,
                            color: ColorStyle.color_4D979797,
                          ),
                          top: BorderSide(
                            width: 1,
                            color: ColorStyle.color_4D979797,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Receive Fund',
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorStyle.color_FF3940FF,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
