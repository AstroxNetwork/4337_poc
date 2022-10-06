import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/widget/refresher_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 加载状态
enum BaseLoadState { loading, succeed, empty, failed }

/// 分页专用
class BaseGetPageController extends BaseGetController {
  /// 当前页数
  int page = 1;

  /// 是否初次加载
  bool hasInit = true;

  Rx<BaseLoadState> loadState = BaseLoadState.loading.obs;
  RefreshController? controller;

  /// 加载成功，是否显示空页面
  void showSuccess(List<Object?> result) {
    loadState.value =
        result.isNotEmpty ? BaseLoadState.succeed : BaseLoadState.empty;
  }

  /// 加载失败,显示失败页面
  void showError() {
    loadState.value = BaseLoadState.failed;
  }

  /// 重新加载
  void showLoading() {
    loadState.value = BaseLoadState.loading;
  }

  /// 预留初次加载，注意只供上拉下拉使用
  Future<void> initPullLoading(RefreshController controller) async {
    if (hasInit) {
      this.controller = controller;
      await requestData(controller);
    }
  }

  ///预留上拉刷新
  Future<void> onLoadRefresh(RefreshController controller) {
    page = 1;
    return requestData(controller, refresh: Refresh.pull);
  }

  ///预留下拉加载
  Future<void> onLoadMore(RefreshController controller) {
    ++page;
    return requestData(controller, refresh: Refresh.down);
  }

  /// 网络请求在此处进行，不用在重复进行上拉下拉的处理
  Future<void> requestData(
    RefreshController controller, {
    Refresh refresh = Refresh.first,
  }) async {}
}
