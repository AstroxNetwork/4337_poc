import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:get/get.dart';

class EmailController extends BaseGetController {
  int countdown = 60;
  bool isVerification = false;
  late Timer timer;

  sendVerification() {
    /// Skyh
    // var params = Map();
    // params['email'] = 'skyhighfeng@gmail.com';
    // params['code'] = '198GFG';
    // final response = await Request.addAccount(params);
    // {"code":400,"msg":"Code is not valid.","data":{}}
    // {"code":200,"msg":"Add record successfully.","data":{"jwtToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNreWhpZ2hmZW5nQGdtYWlsLmNvbSIsImlhdCI6MTY2NDQ1ODgzOSwiZXhwIjoxNjY1NzU0ODM5fQ.QssiBtGElqIwuzSIaZJyRW8Jyw_iNQmDFQaEOdm2Bmg"}}

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
    /// Skyh
    // var params = Map();
    // params['email'] = 'skyhighfeng@gmail.com';
    // final response = await Request.verifyEmail(params);
    Get.toNamed(Routes.passwordPage);
  }
}
