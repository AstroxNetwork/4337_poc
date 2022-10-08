import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TradeMarkWidget extends StatelessWidget {
  const TradeMarkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Powered by ',
          style: TextStyle(
            fontSize: 16,
            color: ColorStyle.color_black_70,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Image.asset(
            R.ASSETS_ASTROX_LOGO_PNG,
            width: 86,
          ),
        )
      ],
    );
  }
}
