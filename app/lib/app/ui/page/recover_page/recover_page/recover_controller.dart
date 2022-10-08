import 'dart:math' as math;

import 'package:agent_dart/utils/number.dart';
import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/eip4337lib/backend/request.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/define/address.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:get/get.dart';

class RecoverController extends BaseGetController {
  final Map<String, dynamic> _arguments = Get.arguments;
  late final String _email = _arguments['email'], _code = _arguments['code'];
  late final List<String> allData = _arguments['guardians'];
  final List<String> selectedData = [];

  int get requiredGuardians => math.max(2, (allData.length / 2).ceil());

  void toggleCheck(String model) {
    if (selectedData.contains(model)) {
      selectedData.remove(model);
    } else {
      selectedData.add(model);
    }
    update();
  }

  Future<void> startTransaction() async {
    if (selectedData.length < requiredGuardians) {
      ToastUtil.show('Select more guardians before send request.');
      return;
    }
    final selected = selectedData.toList()
      ..sort((a, b) => BigInt.parse(a).compareTo(BigInt.parse(b)));
    loadingStart();
    try {
      final newOwner = WalletContext.getInstance().account.address;
      final recoveryOp = await WalletContext.getInstance().transferOwner(
        newOwner,
      );
      final requestId = recoveryOp.requestId(
        Goerli.entryPointAddress,
        Goerli.chainId,
      );
      final result = await Request.addRecover({
        'email': _email,
        'code': _code,
        'new_key': newOwner.hex,
        'request_id': bytesToHex(requestId, include0x: true),
      });
      if (result.data?['code'] == 200) {
        Get.toNamed(
          Routes.transactionPage,
          arguments: {
            'email': _email,
            'code': _code,
            'new_key': newOwner.hex,
            'request_id': requestId,
            'selected': selected,
          },
        );
      } else {
        LogUtil.w(result.data);
      }
    } catch (e, s) {
      LogUtil.e(e, stackTrace: s);
    }
    loadingStop();
  }
}
