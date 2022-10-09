import 'package:app/app/http/request_repository.dart';
import 'package:app/app/ui/widget/loading_widget.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/net/ExceptionHandle.dart';
import 'package:app/net/dio_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 基类 Controller
class BaseGetController extends GetxController {
  final RxBool _isLoading = false.obs;
  late final CancelToken _cancelToken = CancelToken();
  late RequestRepository request = Get.find<RequestRepository>();

  SharedPreferences get sp => Get.find<SharedPreferences>();
  LocalStorage? storage;

  /// 初始化 [GetxController]，例如一些成员属性的初始化
  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    try {
      var hex = WalletContext.getInstance().walletAddress.hex;
      if (hex.isNotEmpty) {
        storage = LocalStorage(hex);
      }
    } catch (_) {}

    _isLoading.listen((isLoading) {
      if (isLoading) {
        LoadingWidget.show();
      } else {
        LoadingWidget.dismiss();
      }
    });
  }

  /// 就绪后的业务处理，如异步操作、导航进入的参数处理
  @mustCallSuper
  @override
  void onReady() {
    super.onReady();
  }

  /// 释放资源，避免内存泄露，同时也可以进行数据持久化
  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    // 销毁时，将请求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
    final isClosed = _isLoading.subject.isClosed;
    if (!isClosed) {
      _isLoading.close();
    }
  }

  void onVisibility() {}

  void loadingStart() {
    _isLoading.value = true;
  }

  void loadingStop() {
    _isLoading.value = false;
  }

  /// 返回 Future 适用于刷新、加载更多
  Future<void> requestNetwork<T>(
    Method method, {
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
      loadingStart();
    }
    return DioUtils.instance.requestNetwork<T>(
      method,
      url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSuccess: (data) {
        if (isShow) {
          loadingStop();
        }
        onSuccess?.call(data);
      },
      onError: (code, msg) {
        if (isShow) {
          loadingStop();
        }
        _onError(code, msg, onError);
      },
    );
  }

  void _onError(int code, String msg, NetErrorCallback? onError) {
    if (code != ExceptionHandle.cancel_error) {
      ToastUtil.show(msg);
    }
    // 页面如果dispose，则不回调onError
    if (onError != null) {
      onError(code, msg);
    }
  }
}
