import 'package:app/app/res/colors.dart';
import 'package:flutter/material.dart';

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

  Button(
      {super.key,
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
      this.fontWeight = FontWeight.w700});

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
        // style: ButtonStyle(
        //   padding: MaterialStateProperty.all(
        //       const EdgeInsets.fromLTRB(27, 19, 26, 18)),
        // ),
        onPressed: onPressed,
        child: Text(
          data,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: fontColor,
            letterSpacing: -0.48,
          ),
        ),
      ),
    );
  }
}
