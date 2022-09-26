import 'package:app/app/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  double width;
  double height;
  VoidCallback onPressed;

  double radius;
  Color color;
  Color borderColor;
  double borderWidth;

  String data;
  double fontSize;
  Color fontColor;
  FontWeight fontWeight;

  Widget? image;
  double space;

  Button({
    super.key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.data,
    this.radius = 31,
    this.color = ColorStyle.color_FF3940FF,
    this.borderColor = ColorStyle.color_FF3940FF,
    this.borderWidth = 0,
    this.fontSize = 20,
    this.fontColor = Colors.white,
    this.fontWeight = FontWeight.w700,
    this.image,
    this.space = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: borderWidth != 0
            ? Border.all(
                color: borderColor,
                width: borderWidth,
              )
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Padding(
                padding: EdgeInsets.only(right: space),
                child: image!,
              ),
            Text(
              data,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: fontColor,
                letterSpacing: -0.48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
