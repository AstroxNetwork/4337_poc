import 'package:app/app/ui/page/guardian_page/guardian_controller.dart';
import 'package:get/get.dart';

class GuardianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuardianController());
  }
}
