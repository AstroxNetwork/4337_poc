import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/widget/refresher_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 分页专用，如果页面中有分页加载，请使用此BaseGetPageController
class BaseGetPageController extends BaseGetController {
  ///加载状态  0加载中 1加载成功 2加载数据为空 3加载失败
  var loadState = 0.obs;

  ///当前页数
  int page = 1;

  ///是否初次加载
  var isInit = true;

  var controller;

  ///加载成功，是否显示空页面
  showSuccess(List suc) {
    loadState.value = suc.isNotEmpty ? 1 : 2;
  }

  ///加载失败,显示失败页面
  showError() {
    loadState.value = 3;
  }

  ///重新加载
  showLoading() {
    loadState.value = 0;
  }

  ///预留初次加载，注意只供上拉下拉使用
  initPullLoading(RefreshController controller) {
    if (isInit) {
      this.controller = controller;
      requestData(controller);
    }
  }

  ///预留上拉刷新
  onLoadRefresh(RefreshController controller) {
    page = 1;
    requestData(controller, refresh: Refresh.pull);
  }

  ///预留下拉加载
  onLoadMore(RefreshController controller) {
    ++page;
    requestData(controller, refresh: Refresh.down);
  }

  ///网络请求在此处进行，不用在重复进行上拉下拉的处理
  void requestData(RefreshController controller,
      {Refresh refresh = Refresh.first}) {}
}
