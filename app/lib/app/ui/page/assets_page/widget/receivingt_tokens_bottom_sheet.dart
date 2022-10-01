import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReceivingTokensBottomSheet extends GetCommonView<AssetsController> {
  const ReceivingTokensBottomSheet({super.key});

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
            padding: EdgeInsets.only(top: 24),
            child: Text(
              'Receiving Tokens',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 39),
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
          const SizedBox(
            width: 220,
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                '0x6b5cf860506c6291711478F54123312066944B3',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorStyle.color_000000_50,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 37),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset(
                    R.assetsImagesCopy,
                    width: 16,
                    height: 16,
                  ),
                  onTap: () => onCopy(),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Copy',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: -0.38,
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

  onCopy() {
    Clipboard.setData(
      const ClipboardData(
        text: '0x6b5cf860506c6291711478F54123312066944B3…CbEF',
      ),
    );
  }
}
