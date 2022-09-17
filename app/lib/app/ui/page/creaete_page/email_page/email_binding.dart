import 'package:app/app/ui/page/creaete_page/email_page/email_controller.dart';
import 'package:get/get.dart';

class EmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailController());
  }
}
