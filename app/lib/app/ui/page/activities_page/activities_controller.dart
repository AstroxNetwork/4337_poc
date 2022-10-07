import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:localstorage/localstorage.dart';

class ActivitiesController extends BaseGetController {

  LocalStorage? storage;

  @override
  void onInit() {
    super.onInit();
    var hex = WalletContext.getInstance().walletAddress?.hex;
    if (hex != null && hex.isNotEmpty) {
      // storage = new LocalStorage(hex, '', (_) {
      //
      // });
    }
  }

  @override
  void onVisiablity() {
    super.onVisiablity();
  }

  fetchActivities() {

  }
}
