import 'package:app/app/ui/page/recover_page/signed_page/signed_controller.dart';
import 'package:get/get.dart';

class SignedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignedController());
  }
}
