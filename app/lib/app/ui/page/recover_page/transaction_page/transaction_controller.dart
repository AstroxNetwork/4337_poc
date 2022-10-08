import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:agent_dart/utils/string.dart';
import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/eip4337lib/backend/request.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/web3dart/credentials.dart';
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
    _checkRecoveryRecords();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkRecoveryRecords();
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future<void> _checkRecoveryRecords() async {
    final result = await Request.fetchRecover({'new_key': newAddress});
    LogUtil.d(const JsonEncoder.withIndent('  ').convert(result.data!));
    final Map<String, dynamic> data = result.data!['data']!;
    final List<Map<String, dynamic>> recordsData = data['recoveryRecords']
            ['recovery_records']
        .cast<Map<String, dynamic>>();
    final records = recordsData.map(_Record.fromJson).toList();
    for (final record in records) {
      if (record.signature != null && guardians[record.address] == false) {
        guardians[record.address] = true;
        update();
      }
    }
    final requirements = _Requirements.fromJson(
      data['requirements'] as Map<String, dynamic>,
    );
    if (requirements.hasPassed) {
      final List<Map<String, dynamic>> recordsData = data['recoveryRecords']
              ['recovery_records']
          .cast<Map<String, dynamic>>();
      final List<_Record> records = recordsData
          .map(_Record.fromJson)
          .where((e) => e.signature != null)
          .toList();
      if (records.length < requirements.min) {
        return;
      }
      records.sort((a, b) {
        final aBn = BigInt.parse(a.address);
        final bBn = BigInt.parse(b.address);
        return aBn.compareTo(bBn);
      });
      _timer.cancel();
      _finishRecover(records);
    }
  }

  Future<void> _finishRecover(List<_Record> records) async {
    loadingStart();
    try {
      await WalletContext.getInstance().recoverWallet(
        EthereumAddress(Uint8List.fromList(hexToBytes(newAddress))),
        records.map((e) => e.toRecover()).toList(),
      );
    } catch (e, s) {
      LogUtil.e(e, stackTrace: s);
    }
    loadingStop();
    Get.offAllNamed(Routes.signedPage);
  }
}

class _Record {
  const _Record(this.id, this.address, this.signature);

  factory _Record.fromJson(Map<String, dynamic> json) {
    return _Record(
      json['_id'] as String,
      json['guardian_address'] as String,
      json['signature'] as String?,
    );
  }

  final String id;
  final String address;
  final String? signature;

  List<Object> toRecover() {
    return [
      EthereumAddress.fromHex(address),
      Uint8List.fromList(hexToBytes(signature!)),
    ];
  }
}

class _Requirements {
  const _Requirements(this.total, this.min, this.signed);

  factory _Requirements.fromJson(Map<String, dynamic> json) {
    return _Requirements(
      json['total'] as int,
      json['min'] as int,
      json['signedNum'] as int,
    );
  }

  final int total;
  final int min;
  final int signed;

  bool get hasPassed => signed >= min;
}
