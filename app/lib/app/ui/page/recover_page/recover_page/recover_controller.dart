import 'dart:math' as math;

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:get/get.dart';

class RecoverController extends BaseGetController {
  final Map<String, dynamic> _arguments =
      Map<String, dynamic>.from(Get.arguments);

  late final String _email = _arguments['email'],
      _code = _arguments['code'],
      _newOwner = _arguments['new_key'],
      _requestId = _arguments['request_id'];
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
    Get.toNamed(
      Routes.transactionPage,
      arguments: {
        'email': _email,
        'code': _code,
        'new_key': _newOwner,
        'request_id': _requestId,
        'selected': selected,
      },
    );
  }
}
