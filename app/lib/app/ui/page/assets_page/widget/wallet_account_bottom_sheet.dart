import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletAccountBottomSheet extends GetCommonView<AssetsController> {
  const WalletAccountBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        color: appThemeData.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              'Wallet Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Image.network(
                    '',
                    errorBuilder: (_, __, ___) => CircleAvatar(
                      radius: 20,
                      child: Image.asset(
                        R.ASSETS_IMAGES_DEFAULT_AVATAR_PNG,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Account 1',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 33),
                  child: Button(
                    width: 115,
                    height: 40,
                    onPressed: () => onLogOut(),
                    data: 'Log Out',
                    color: appThemeData.scaffoldBackgroundColor,
                    borderColor: ColorStyle.color_80FF0000,
                    borderWidth: 2,
                    fontSize: 16,
                    fontColor: ColorStyle.color_CCFF0000,
                    fontWeight: FontWeight.w700,
                    image: Image.asset(
                      R.ASSETS_IMAGES_LOGOUT_PNG,
                      width: 18,
                      height: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  onLogOut() {
    Get.offAllNamed(
      Routes.loginPage,
      arguments: {'showPasswordsImmediately': false},
    );
  }
}
