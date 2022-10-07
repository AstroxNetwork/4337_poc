import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationsBottomSheet extends StatelessWidget {
  const CongratulationsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appThemeData.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 34, right: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                R.ASSETS_IMAGES_CONGRATULATIONS_PNG,
                width: 42,
                height: 42,
              ),
            ),
            const Text(
              'Congratulations',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 26),
              child: Text(
                'You’ve successfully created a new wallet, you now can receive fund with it.',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorStyle.color_black_80,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'To unlock full feature, please deploy the wallet by click the "',
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorStyle.color_black_80,
                      ),
                    ),
                    TextSpan(
                      text: 'Activate My Wallet',
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorStyle.color_3940FF_80,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: ' " button and finish the proccess.',
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorStyle.color_black_80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Button(
                width: double.infinity,
                height: 61,
                onPressed: () => Get.back(),
                data: 'OK',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
