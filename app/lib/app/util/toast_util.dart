import 'package:app/app/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastUtil {
  static void show(String data, {int duration = 2}) {
    OverlayEntry entry = OverlayEntry(builder: (context) {
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: ColorStyle.color_black_70,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 42, top: 28, right: 42, bottom: 28),
              child: Text(
                data,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(Get.overlayContext!)!.insert(entry);
    Future.delayed(Duration(seconds: duration)).then((value) {
      entry.remove();
    });
  }
}
