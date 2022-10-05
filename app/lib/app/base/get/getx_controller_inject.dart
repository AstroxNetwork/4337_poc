import 'package:app/app/http/request_repository.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/net/ExceptionHandle.dart';
import 'package:app/net/dio_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

/// 基类 Controller
class BaseGetController extends GetxController {
  late RequestRepository request;
  RxBool isLoading = false.obs;

  late CancelToken _cancelToken;

  /// 初始化 Controller，例如一些成员属性的初始化
  @override
  void onInit() {
    super.onInit();
    request = Get.find<RequestRepository>();
    _cancelToken = CancelToken();
  }

  /// 返回Future 适用于刷新，加载更多
  Future<dynamic> requestNetwork<T>(Method method, {
    required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    if (isShow) {
      isLoading.value = true;
    }
    return DioUtils.instance.requestNetwork<T>(method, url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken?? _cancelToken,
      onSuccess: (data) {
        if (isClose) {
          isLoading.value = false;
        }
        onSuccess?.call(data);
      },
      onError: (code, msg) {
        _onError(code, msg, onError);
      },
    );
  }

  void _onError(int code, String msg, NetErrorCallback? onError) {
    isLoading.value = false;
    if (code != ExceptionHandle.cancel_error) {
      ToastUtil.show(msg);
    }
    /// 页面如果dispose，则不回调onError
    if (onError != null) {
      onError(code, msg);
    }
  }

  void requestPost<T>(String url,
      {NetSuccessCallback<T?>? onSuccess,
      NetErrorCallback? onError,
      Object? params}) {
    isLoading.value = true;
    DioUtils.instance.requestNetwork(Method.post, url, params: params, onSuccess: (T? res) {
      isLoading.value = false;
      onSuccess?.call(res);
    }, onError: (int code, String msg) {
      isLoading.value = false;
      onError?.call(code, msg);
    });
    // HttpUtils.instance.requestPost<T>(url, params: params, onSuccess: (T? res) {
    //   isLoading.value = false;
    //   onSuccess?.call(res);
    // }, onError: (int code, String msg) {
    //   isLoading.value = false;
    //   onError?.call(code, msg);
    // });
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
    /// 销毁时，将请求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
