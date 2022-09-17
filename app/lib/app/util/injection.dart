import 'package:app/app/http/request_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 依赖注入
class Injection {
  static Future<void> init() async {
    await Get.putAsync(() => SharedPreferences.getInstance());
    Get.lazyPut(() => RequestRepository());
  }
}
