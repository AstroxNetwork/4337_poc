import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/data_model.dart';
import 'package:get/get.dart';

class TransactionController extends BaseGetController {
  List<GuardianModel> data = Get.arguments;
}
