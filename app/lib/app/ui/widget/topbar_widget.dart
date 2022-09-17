import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/r.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  bool isInfo;

  TopBar({super.key, this.isInfo = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isInfo
            ? Padding(
                padding: const EdgeInsets.only(left: 30),
                child: GestureDetector(
                  child: Image.asset(
                    R.assetsImagesTopbarInfo,
                    width: 28,
                    height: 28,
                  ),
                  onTap: () {},
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 34),
                child: GestureDetector(
                  child: Image.asset(
                    R.assetsImagesArrowLeft,
                    width: 14,
                    height: 24,
                  ),
                  onTap: () => Get.back(),
                ),
              ),
        GestureDetector(
          child: Image.asset(
            R.assetsImagesAppIconMid,
            width: 139,
            height: 39,
          ),
          onTap: () => Get.back(),
        ),
        SizedBox(
          width: isInfo ? 58 : 48,
        ),
      ],
    );
  }
}
