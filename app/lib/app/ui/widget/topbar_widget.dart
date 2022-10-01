import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  bool needInfo;
  bool needScan;
  bool needBack;

  TopBar(
      {super.key,
      this.needInfo = false,
      this.needScan = false,
      this.needBack = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!needInfo && !needBack)
          const SizedBox(
            width: 28,
            height: 28,
          ),
        if (needInfo)
          GestureDetector(
            child: Image.asset(
              R.assetsImagesTopbarInfo,
              width: 28,
              height: 28,
            ),
            onTap: () => onInfoIconClick(),
          ),
        if (needBack)
          GestureDetector(
            child: Image.asset(
              R.assetsImagesArrowLeft,
              width: 28,
              height: 28,
            ),
            onTap: () => Get.back(),
          ),
        Image.asset(
          R.assetsImagesAppIconMid,
          width: 139,
          height: 39,
        ),
        if (needScan)
          GestureDetector(
            child: Image.asset(
              R.assetsImagesScan,
              width: 28,
              height: 28,
            ),
            onTap: () => onScanClick(),
          ),
        if (!needScan)
          const SizedBox(
            width: 28,
            height: 28,
          ),
      ],
    );
  }

  onInfoIconClick() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        height: 560,
        decoration: BoxDecoration(
          color: appThemeData.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 34, top: 34, right: 34, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  R.assetsImagesAppIconMid,
                  width: 139,
                  height: 39,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Description text Description text Description text Description text Description text Description text Description text ',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorStyle.color_black_60,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 27),
                child: Text(
                  'Contact us',
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorStyle.color_black_60,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  // todo: 分享
                ],
              ),
              const Spacer(),
              Button(
                width: double.infinity,
                height: 61,
                onPressed: () => Get.back(),
                data: 'OK',
              )
            ],
          ),
        ),
      ),
    );
  }

  onScanClick() {}
}
