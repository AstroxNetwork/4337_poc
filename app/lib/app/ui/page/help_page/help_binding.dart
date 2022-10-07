import 'package:app/app/ui/page/help_page/help_controller.dart';
import 'package:get/get.dart';

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpController());
  }
}
