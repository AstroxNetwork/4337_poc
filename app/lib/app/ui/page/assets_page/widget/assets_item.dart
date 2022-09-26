import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:flutter/material.dart';

class AssetsItem extends GetCommonView<AssetsController> {
  const AssetsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 25, bottom: 25),
              child: Image.network(
                '',
                errorBuilder: (_, __, ___) => Image.asset(
                  R.assetsImagesDefaultAssetsItemIcon,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '0.00',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorStyle.color_80000000,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'ETF',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorStyle.color_80000000,
                ),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 33, right: 33),
          child: Divider(
            height: 1,
            color: ColorStyle.color_4D979797,
          ),
        )
      ],
    );
  }
}
