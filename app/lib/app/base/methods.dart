import 'package:app/app/util/toast_util.dart';
import 'package:flutter/services.dart';

void copyAndToast(String data) {
  Clipboard.setData(ClipboardData(text: data));
  HapticFeedback.mediumImpact();
  ToastUtil.show('Copied!');
}
