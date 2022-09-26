import 'package:app/app/http/request_repository.dart';
import 'package:get/get.dart';

/// 基类 Controller
class BaseGetController extends GetxController {
  late RequestRepository request;

  /// 初始化 Controller，例如一些成员属性的初始化
  @override
  void onInit() {
    super.onInit();
    request = Get.find<RequestRepository>();
  }

  /// 就绪后的业务处理，如异步操作、导航进入的参数处理
  @override
  void onReady() {
    super.onReady();
  }

  /// 释放资源，避免内存泄露，同时也可以进行数据持久化
  @override
  void onClose() {
    super.onClose();
  }
}
