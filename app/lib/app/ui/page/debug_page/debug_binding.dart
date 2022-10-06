import 'package:app/app/ui/page/debug_page/debug_controller.dart';
import 'package:get/get.dart';

class DebugBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DebugController());
  }
}
