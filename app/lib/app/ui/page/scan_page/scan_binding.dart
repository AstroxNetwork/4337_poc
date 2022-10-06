import 'package:app/app/ui/page/guardian_page/guardian_controller.dart';
import 'package:app/app/ui/page/scan_page/scan_controller.dart';
import 'package:get/get.dart';

class ScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScanController());
  }
}
