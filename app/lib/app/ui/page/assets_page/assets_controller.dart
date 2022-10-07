import 'dart:async';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/asset_model.dart';
import 'package:app/app/model/user_model.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/assets_page/widget/activate_wallet_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/without_wallet_dialog.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/jazzicon/jazzicon.dart';
import 'package:app/jazzicon/jazziconshape.dart';
import 'package:app/web3dart/credentials.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AssetsController extends BaseGetController {
  // List<String> currencys = ['ETH', 'BTC'];

  late UserModel userModel;
  late Rx<JazziconData?> jazziconData = Rx<JazziconData?>(null);

  RxList<AssetModel> assets = <AssetModel>[].obs;
  RxMap<String, String> balanceMap = <String, String>{}.obs;
  late Timer timer;

  TextEditingController toController = TextEditingController(text: '');
  TextEditingController tokenController = TextEditingController(text: '');
  String tokenSeleted = 'ETH';

  @override
  void onInit() {
    super.onInit();
    LogUtil.d('AssetsController onInit');
    assets.value = [
      AssetModel(
          icon: R.assetsImagesTokenETH,
          symbol: 'ETH',
          address: '0x0000000000000000000000000000000000000000'),
      AssetModel(
          icon: R.assetsImagesTokenWETH,
          symbol: 'WETH',
          address: '0xec2a384Fa762C96140c817079768a1cfd0e908EA'),
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
    loadingStart();
    bool isContract = false;
    try {
      await WalletContext.getInstance().activateWallet();
      isContract = await WalletContext.getInstance().isWalletContract();
    } catch (_) {}
    loadingStop();
    if (!isContract) {
      Get.dialog(const WithoutWalletDialog());
    } else {
      Get.bottomSheet(const ActivateWalletBottomSheet());
    }
  }

  void generateJazzIcon() async {
    Future(() {
      jazziconData.value = Jazzicon.getJazziconData(60,
          address: WalletContext.getInstance().walletAddress?.hex);
    });
  }

  List<String> getCurrencys() {
    return assets.value.map((e) => e.symbol).toList();
  }

  Future sendTokens() async {
    final toAddress = EthereumAddress.fromHex(toController.text);
    final amount = BigInt.parse(tokenController.text);
    try {
      print('sendTokens $toAddress, $amount');
      if (tokenSeleted == 'ETH') {
        await WalletContext.getInstance().sendETH(toAddress, amount);
      } else if (tokenSeleted == 'WETH') {
        final tokenAddress = EthereumAddress.fromHex('0xec2a384Fa762C96140c817079768a1cfd0e908EA');
        await WalletContext.getInstance().sendERC20(tokenAddress, toAddress, amount);
      }
    } catch (_) {}

  }
}
