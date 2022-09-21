import 'package:app/app/ui/page/creaete_page/password_page/password_controller.dart';
import 'package:get/get.dart';

class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordController());
  }
}
