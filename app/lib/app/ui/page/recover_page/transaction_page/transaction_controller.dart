import 'dart:async';
import 'dart:convert';

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
    final records =
        result.data!['recovery_records'].map(_Record.fromJson).toList();
    final requirements = _Requirements.fromJson(result.data!['requirements']);
    LogUtil.d(const JsonEncoder.withIndent('  ').convert(result.data!));
    LogUtil.d(records);
    LogUtil.d(requirements);
  }
}

class _Record {
  const _Record(this.id, this.address, this.signature);

  factory _Record.fromJson(Map<String, Object?> json) {
    return _Record(
      json['_id'] as String,
      json['guardian_address'] as String,
      json['signature'] as String?,
    );
  }

  final String id;
  final String address;
  final String? signature;
}

class _Requirements {
  const _Requirements(this.total, this.min, this.signed);

  factory _Requirements.fromJson(Map<String, Object?> json) {
    return _Requirements(
      json['total'] as int,
      json['min'] as int,
      json['signedNum'] as int,
    );
  }

  final int total;
  final int min;
  final int signed;
}
