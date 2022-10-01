import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/recover_page/recover_page/recover_controller.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecoverQRBottomSheet extends GetCommonView<RecoverController> {
  const RecoverQRBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 470,
      decoration: BoxDecoration(
        color: appThemeData.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 27),
            child: Text(
              'QR Code for Guardian',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 59),
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                color: ColorStyle.color_D8D8D8_62,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 37),
            child: Button(
              width: 205,
              height: 40,
              onPressed: () {},
              data: 'Download',
              image: Image.asset(
                R.assetsImagesDownload,
                width: 22,
                height: 22,
              ),
              space: 10,
              borderColor: ColorStyle.color_FF3940FF,
              radius: 20,
              borderWidth: 1,
              color: appThemeData.scaffoldBackgroundColor,
              fontColor: ColorStyle.color_FF3940FF,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
