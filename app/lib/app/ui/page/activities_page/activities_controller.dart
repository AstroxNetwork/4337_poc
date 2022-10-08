import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/data_model.dart';
import 'package:app/constant.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class ActivitiesController extends BaseGetController {

  late RxList<ActivityModel> datas = <ActivityModel>[].obs;
  LocalStorage? storage;

  @override
  void onVisibility() {
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    return Future(() {
      var item = storage?.getItem(
        Constant.KEY_ACTIVITIES,
      ) as List<dynamic>?;
      LogUtil.d('fetchActivities $item');
      List<ActivityModel> activities = [];
      if (item != null) {
        item.forEach((element) {
          activities.add(ActivityModel.fromJson(element));
        });
      }
      datas.clear();
      datas.addAll(activities);
      update();
    });
  }
}
