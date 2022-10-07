import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/data_model.dart';
import 'package:get/get.dart';

class GuardianController extends BaseGetController {
  GuardianModel model = Get.arguments;

  Future<void> removeGuardian() async {
    var guardianModel = model;
    var address = guardianModel.address;
    Get.back<String>(result: address);
  }
}
