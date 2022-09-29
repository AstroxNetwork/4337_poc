import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/edit_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'password_controller.dart';

class PasswordPage extends GetCommonView<PasswordController> {
  const PasswordPage({super.key});

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
                  child: TopBar(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 4, top: 25),
                        child: Text(
                          'Create Password',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4, top: 39),
                        child: Opacity(
                          opacity: 0.4,
                          child: Text(
                            'New Password',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, top: 9),
                        child: Edit(
                          width: 322,
                          height: 55,
                          hintText: 'password',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4, top: 40),
                        child: Opacity(
                          opacity: 0.4,
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, top: 9),
                        child: Edit(
                          width: 322,
                          height: 55,
                          hintText: 'password',
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Button(
                      width: double.infinity,
                      height: 61,
                      onPressed: () => Get.offAllNamed(Routes.homePage),
                      data: 'Confirm',
                      /// restore keystore to local file Skyh
                      // WalletContext.createAccount()  // generate random account
                      // Web3Helper.createWallet(WalletContext.getInstance().account.address, password)
                      // WalletContext.recoverKeystore(json, passeword)
                    ),
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
