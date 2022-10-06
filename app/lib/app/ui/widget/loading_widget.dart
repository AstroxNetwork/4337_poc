import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.size = 100,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final double size;
  final AlignmentGeometry? alignment;

  static Future<void> show({
    Color? backgroundColor,
    double size = 100,
    AlignmentGeometry? alignment = Alignment.center,
  }) async {
    if (SmartDialog.config.loading.isExist) {
      return;
    }
    return SmartDialog.showLoading(
      builder: (_) => LoadingWidget(size: size),
      backDismiss: false,
      clickMaskDismiss: false,
    );
  }

  static Future<void> dismiss() {
    if (SmartDialog.config.loading.isExist) {
      return SmartDialog.dismiss(status: SmartStatus.loading);
    }
    return SynchronousFuture<void>(null);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = GestureDetector(
      onLongPress: () {
        Feedback.forLongPress(context);
        LoadingWidget.dismiss();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xB3000000),
        ),
        child: const Text(
          'Loading...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    if (alignment != null) {
      body = Align(alignment: alignment!, child: body);
    }
    return body;
  }
}
