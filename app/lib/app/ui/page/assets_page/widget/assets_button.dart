import 'package:app/app/res/colors.dart';
import 'package:flutter/material.dart';

class AssetsButton extends StatelessWidget {
  String data;
  String image;
  GestureTapCallback onTap;

  AssetsButton({
    Key? key,
    required this.data,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 80,
        decoration: const BoxDecoration(
          color: ColorStyle.color_0D3940FF,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 24,
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                data,
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorStyle.color_99000000,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
