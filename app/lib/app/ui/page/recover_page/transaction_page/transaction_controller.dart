import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/eip4337lib/backend/request.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:get/get.dart';

class TransactionController extends BaseGetController {
  final Map<String, dynamic> _arguments = Get.arguments;

  late final String newAddress = _arguments['new_key'];
  late final Map<String, bool> guardians = Map.fromIterable(
    _arguments['selected'] as List<String>,
    value: (_) => false,
  );

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _checkRecoveryRecords();
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  Future<void> _checkRecoveryRecords() async {
    final result = await Request.fetchRecover({'new_key': newAddress});
    LogUtil.d(result);
  }
}
