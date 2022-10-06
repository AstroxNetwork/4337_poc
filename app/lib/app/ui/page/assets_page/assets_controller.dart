import 'dart:async';
import 'dart:math';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/asset_model.dart';
import 'package:app/app/model/user_model.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/assets_page/widget/activate_wallet_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/without_wallet_dialog.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/log_utils.dart';
import 'package:app/jazzicon/jazzicon.dart';
import 'package:app/jazzicon/jazziconshape.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AssetsController extends BaseGetController {
  late UserModel userModel;
  late Rx<JazziconData?> jazziconData = Rx<JazziconData?>(null);

  RxList<AssetModel> assets = <AssetModel>[].obs;
  RxMap<String, String> balanceMap = <String, String>{}.obs;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    Log.d('AssetsController onInit');
    assets.value = [
      AssetModel(icon: R.assetsImagesTokenETH, symbol: 'ETH', address: '0x0000000000000000000000000000000000000000'),
      AssetModel(icon: R.assetsImagesTokenWETH, symbol: 'WETH', address: '0xec2a384Fa762C96140c817079768a1cfd0e908EA'),
    ];
    userModel = UserModel(
      name: 'Soul Wallet',
      avatar: '',
      address: WalletContext.getInstance().walletAddress?.hex ?? '',
    );
    // fetchBalance();
    generateJazzIcon();
    notifyUserModel();
  }

  void notifyUserModel() {
    fetchBalance();
    // update();
  }

  onCopy() {
    Clipboard.setData(ClipboardData(
      text: userModel.address,
    ));
    ToastUtil.show("Copied");
  }

  void fetchBalance() {
    assets.value.forEach((element) async {
      Map<String, String> balanceMapping = Map();
      balanceMapping.addAll(balanceMap.value);
      double balance = 0.0;
      if (element.symbol == 'ETH') {
        balance = await WalletContext.getInstance().getEthBalance();
      } else {
        balance = await WalletContext.getInstance().getWEthBalance();
      }
      print('element.address = ${element.address}');
      balanceMapping[element.address] = '$balance';
      balanceMap[element.address] = '$balance';
      update();
    });
  }

  onActivateMyWallet() async {
    isLoading.value = true;
    var walletType = '';
    try {
      await WalletContext.getInstance().activateWallet();
      walletType = await WalletContext.getInstance().getWalletType();
    } catch (err) {}
    isLoading.value = false;
    if (walletType != "contract") {
      Get.dialog(const WithoutWalletDialog());
    } else {
      Get.bottomSheet(const ActivateWalletBottomSheet());
    }
  }

  void generateJazzIcon() async {
    Future(() {
      jazziconData.value = Jazzicon.getJazziconData(60, address: WalletContext.getInstance().walletAddress?.hex);
    });
  }
}
