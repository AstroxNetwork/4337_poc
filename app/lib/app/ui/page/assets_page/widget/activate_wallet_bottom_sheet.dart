import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivateWalletBottomSheet extends GetCommonView<AssetsController> {
  const ActivateWalletBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 460,
      decoration: BoxDecoration(
        color: appThemeData.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                'Activate My Wallet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 9),
              child: Text(
                'Deploy wallet to unlock full feature, the process takes no more than 1 minute.',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorStyle.color_black_80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorStyle.color_F5F5F5,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Gas Fee',
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorStyle.color_black_80,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          '0.005 ETH',
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorStyle.color_black_80,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    onPressed: () {
                      Get.back();
                      ToastUtil.show('Wallet Acitvated');
                    },
                    data: 'Continue',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
