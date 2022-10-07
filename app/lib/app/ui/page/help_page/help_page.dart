import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/help_page/help_controller.dart';
import 'package:app/app/ui/page/help_page/widget/sign_transaction_bottom_sheet.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HelpPage extends GetCommonView<HelpController> {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(
                    needBack: true,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 4, top: 25),
                  child: Text(
                    'Help Your Friend Recover the wallet by Signing Transaction',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 87, right: 15),
                  child: Card(
                    color: ColorStyle.color_F3F3FF,
                    shadowColor: ColorStyle.color_black_80,
                    elevation: 4,
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Wallet Address:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: Text(
                                controller.address,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: ColorStyle.color_black_80,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4, bottom: 50),
                  child: Button(
                    width: double.infinity,
                    height: 61,
                    onPressed: () => onSignPress(),
                    data: 'Sign Transaction',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSignPress() {
    Get.bottomSheet(
      const SignTransactionBottomSheet(),
    );
  }
}
