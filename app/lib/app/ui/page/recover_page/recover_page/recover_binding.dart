import 'package:app/app/ui/page/recover_page/recover_page/recover_controller.dart';
import 'package:get/get.dart';

class RecoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecoverController());
  }
}
