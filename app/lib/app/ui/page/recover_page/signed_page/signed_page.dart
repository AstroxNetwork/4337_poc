import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/recover_page/signed_page/signed_controller.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignedPage extends GetCommonView<SignedController> {
  const SignedPage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 83),
                  child: Image.asset(
                    R.ASSETS_IMAGES_TRANSACTION_SIGNED_PNG,
                    width: 80,
                    height: 80,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    'Transaction signed.',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Button(
                    width: double.infinity,
                    height: 61,
                    onPressed: () => Get.offNamed(
                      Routes.passwordPage,
                      arguments: {
                        'email': controller.email,
                        'shouldUpdateAccount': false,
                      },
                    ),
                    data: 'Setup New Password',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
