import 'package:app/app/base/get/getx_controller_inject.dart';

class HomeController extends BaseGetController {
  int tabIndex = 0;

  changeTab(int index) {
    tabIndex = index;
    update();
  }
}
