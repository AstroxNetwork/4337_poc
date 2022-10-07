import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/page/activities_page/activities_controller.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/page/guardians_page/guardians_controller.dart';
import 'package:app/app/ui/page/home_page/widget/congratulations_bottom_sheet.dart';
import 'package:get/get.dart';

class HomeController extends BaseGetController {
  bool? needShowCongratulation = Get.arguments;

  int tabIndex = 0;

  changeTab(int index) {
    tabIndex = index;
    if (index == 0) {
      Get.find<AssetsController>().onVisibility();
    } else if (index == 1) {
      Get.find<ActivitiesController>().onVisibility();
    } else if (index == 2) {
      Get.find<GuardiansController>().onVisibility();
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
    if (needShowCongratulation ?? false) {
      Get.bottomSheet(
        const CongratulationsBottomSheet(),
      );
    }
  }
}
