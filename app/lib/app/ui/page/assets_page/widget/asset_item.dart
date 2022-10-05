import 'package:app/app/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetItem extends StatelessWidget {
  String icon;
  String count;
  String symbol;

  AssetItem(
      {Key? key, required this.icon, required this.count, required this.symbol})
      : super(key: key);

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
              child: icon.endsWith('.svg')
                  ? SvgPicture.asset(
                      icon,
                      width: 30,
                      height: 30,
                    )
                  : Image.asset(
                      icon,
                      width: 30,
                      height: 30,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                count,
                style: const TextStyle(
                  fontSize: 18,
                  color: ColorStyle.color_000000_50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                symbol,
                style: const TextStyle(
                  fontSize: 18,
                  color: ColorStyle.color_000000_50,
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
