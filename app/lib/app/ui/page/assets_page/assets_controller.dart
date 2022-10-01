import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/asset_model.dart';
import 'package:app/app/model/user_model.dart';
import 'package:flutter/material.dart';

class AssetsController extends BaseGetController {
  late UserModel userModel;

  @override
  void onInit() {
    super.onInit();
    // todo: 这里可以考虑做SP UserModel的缓存提高性能
    notifyUserModel();
  }

  void notifyUserModel() {
    // todo: 网络请求获取用户信息
    userModel = UserModel(
      name: 'Account 1',
      avatar: '',
      address: '0x6b5cf860506c6291711478F54123312066944B3',
      assets: [
        AssetModel(count: 100, currency: 'BTC'),
        AssetModel(count: 100, currency: 'BTC'),
        AssetModel(count: 100, currency: 'BTC'),
        AssetModel(count: 100, currency: 'BTC'),
        AssetModel(count: 100, currency: 'BTC'),
        AssetModel(count: 100, currency: 'BTC'),
        AssetModel(count: 100, currency: 'BTC'),
        AssetModel(count: 100, currency: 'BTC'),
        AssetModel(count: 100, currency: 'BTC'),
      ],
    );
    update();
  }
}
