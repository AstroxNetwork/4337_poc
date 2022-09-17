import 'package:app/app/http/request_repository.dart';
import 'package:get/get.dart';

/// 基类 Controller
class BaseGetController extends GetxController {
  late RequestRepository request;

  @override
  void onInit() {
    super.onInit();
    request = Get.find<RequestRepository>();
  }
}
