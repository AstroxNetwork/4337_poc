import 'package:app/app/model/asset_model.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:flutter/material.dart';

class AssetItem extends StatelessWidget {
  AssetModel model;

  AssetItem({Key? key, required this.model}) : super(key: key);

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
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                // todo: 保留两位？
                model.count.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 18,
                  color: ColorStyle.color_000000_50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                model.currency,
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
