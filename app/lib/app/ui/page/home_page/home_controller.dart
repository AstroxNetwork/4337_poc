import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/page/home_page/widget/congratulations_bottom_sheet.dart';
import 'package:get/get.dart';

class HomeController extends BaseGetController {
  int tabIndex = 0;

  changeTab(int index) {
    tabIndex = index;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    Get.bottomSheet(
      const CongratulationsBottomSheet(),
    );
  }
}
