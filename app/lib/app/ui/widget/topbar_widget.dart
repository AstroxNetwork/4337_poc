import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/util/platform_util.dart';
import 'package:app/eip4337lib/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    this.needInfo = false,
    this.needScan = false,
    this.needBack = false,
  });

  final bool needInfo;
  final bool needScan;
  final bool needBack;

  void onInfoIconClick() {
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
                  R.ASSETS_IMAGES_APP_ICON_MID_PNG,
                  width: 139,
                  height: 39,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Description text ' * 10,
                  style: const TextStyle(
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: PlatformUtil.isAndroid ? 15 : 0),
      child: Row(
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
                R.ASSETS_IMAGES_TOPBAR_INFO_PNG,
                width: 28,
                height: 28,
              ),
              onTap: () => onInfoIconClick(),
            ),
          if (needBack)
            GestureDetector(
              child: Image.asset(
                R.ASSETS_IMAGES_ARROW_LEFT_PNG,
                width: 28,
                height: 28,
              ),
              onTap: () => Get.back(),
            ),
          Image.asset(
            R.ASSETS_IMAGES_APP_ICON_MID_PNG,
            width: 139,
            height: 39,
          ),
          if (needScan)
            GestureDetector(
              child: Image.asset(
                R.ASSETS_IMAGES_SCAN_PNG,
                width: 28,
                height: 28,
              ),
              onTap: () async {
                final status = await Permission.camera.request();
                if (status.isGranted) {
                  Get.toNamed(Routes.scanPage);
                }
              },
            ),
          if (!needScan) const SizedBox(width: 28, height: 28),
        ],
      ),
    );
  }
}
