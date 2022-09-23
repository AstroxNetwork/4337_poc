import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:get/get.dart';

class EmailController extends BaseGetController {
  int countdown = 60;
  bool isVerification = false;
  late Timer timer;

  sendVerification() {
    isVerification = true;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        countdown--;
        if (countdown == 0) {
          timer.cancel();
        }
        update();
      },
    );
    update();
  }

  verification() {
    Get.toNamed(Routes.passwordPage);
  }
}