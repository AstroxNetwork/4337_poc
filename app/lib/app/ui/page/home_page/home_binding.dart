import 'package:app/app/ui/page/activities_page/activities_controller.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/page/guardians_page/guardians_controller.dart';
import 'package:app/app/ui/page/home_page/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AssetsController());
    Get.lazyPut(() => ActivitiesController());
    Get.lazyPut(() => GuardiansController());
  }
}
