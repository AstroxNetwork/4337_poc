import 'dart:async';
import 'dart:math';

import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/data_model.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/assets_page/widget/activate_wallet_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/receiving_tokens_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/without_wallet_dialog.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/constant.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/define/address.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/jazzicon/jazzicon.dart';
import 'package:app/jazzicon/jazziconshape.dart';
import 'package:app/web3dart/credentials.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AssetsController extends BaseGetController {
  late UserModel userModel;
  late Rx<JazziconData?> jazziconData = Rx<JazziconData?>(null);

  RxBool isContractWallet = true.obs;
  RxList<AssetModel> assets = <AssetModel>[].obs;
  RxMap<String, String> balanceMap = <String, String>{}.obs;
  RxString sendCurrency = 'ETH'.obs;
  late Timer timer;

  TextEditingController toController = TextEditingController(text: '');
  TextEditingController tokenController = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
    LogUtil.d('AssetsController onInit');
    assets.value = [
      const AssetModel(
        icon: R.ASSETS_IMAGES_TOKENS_ETH_PNG,
        symbol: 'ETH',
        address: '0x0000000000000000000000000000000000000000',
      ),
      const AssetModel(
        icon: R.ASSETS_IMAGES_TOKENS_WETH_PNG,
        symbol: 'WETH',
        address: '0xec2a384Fa762C96140c817079768a1cfd0e908EA',
      ),
    ];
    userModel = UserModel(
      name: 'Soul Wallet',
      avatar: '',
      address: WalletContext.getInstance().walletAddress.hex,
    );
    generateJazzIcon();
    fetchBalance();
    fetchWalletContract();
  }

  @override
  void onVisibility() {
    super.onVisibility();
    LogUtil.d('AssetsController onVisiablity');
    fetchBalance();
    fetchWalletContract();
  }

  Future<void> fetchBalance() {
    LogUtil.d('fetchBalance');
    return Future.wait(assets.map((element) async {
      final Map<String, String> balanceMapping = {...balanceMap};
      final double balance;
      if (element.symbol == 'ETH') {
        balance = await WalletContext.getInstance().getEthBalance();
      } else {
        balance = await WalletContext.getInstance().getWEthBalance();
      }
      LogUtil.d('element.address = ${element.address}');
      balanceMapping[element.address] = '$balance';
      balanceMap[element.address] = '$balance';
      update();
    }));
  }

  Future<void> fetchWalletContract() async {
    final isWalletContract =
        await WalletContext.getInstance().isWalletContract();
    if (isContractWallet.value != isWalletContract) {
      isContractWallet.value = isWalletContract;
    }
    LogUtil.d('isWalletContract: ${isContractWallet.value}');
  }

  onActivateMyWallet() async {
    loadingStart();
    var wEthBalance = await WalletContext.getInstance().getWEthBalance();
    loadingStop();
    if (wEthBalance < 0.01) {
      Get.dialog(const WithoutWalletDialog());
      return;
    }
    Get.bottomSheet(ActivateWalletBottomSheet(
      onContinue: () async {
        loadingStart();
        try {
          await WalletContext.getInstance().activateWallet();
          isContractWallet.value =
              await WalletContext.getInstance().isWalletContract();
        } catch (err) {
          if (err.toString().isNotEmpty) ToastUtil.show(err.toString());
        }
        if (isContractWallet.value) {
          Get.back();
          loadingStop();
        }
      },
    ));
  }

  void generateJazzIcon() async {
    Future(() {
      jazziconData.value = Jazzicon.getJazziconData(60,
          address: WalletContext.getInstance().walletAddress.hex);
    });
  }

  List<String> getCurrencys() {
    return assets.map((e) => e.symbol).toList();
  }

  Future sendTokens() async {
    var toAddressStr = toController.text;
    var tokenStr = tokenController.text;
    if (tokenStr.isEmpty) {
      ToastUtil.show('"Amount not valid"');
      return;
    }
    loadingStart();
    try {
      final toAddress = EthereumAddress.fromHex(toAddressStr);
      var amountDouble = double.parse(tokenStr);
      final amount = BigInt.from(amountDouble * pow(10, 18));
      String txhash = '';
      LogUtil.d('sendTokens $sendCurrency $toAddress, $amount');
      if (sendCurrency.value == 'ETH') {
        txhash = await WalletContext.getInstance().sendETH(toAddress, amount);
      } else if (sendCurrency.value == 'WETH') {
        final tokenAddress = Goerli.wethAddress;
        txhash = await WalletContext.getInstance().sendERC20(
          tokenAddress,
          toAddress,
          amount,
        );
      }
      if (sendCurrency.value.isNotEmpty) {
        addActivity(ActivityModel(
          date: DateTime.now(),
          type: ActivityType.send,
          address: toAddressStr,
          count: amountDouble,
          currency: sendCurrency.value,
          txhash: txhash
        ));
      }
      fetchBalance();
      Get.back();
    } on ArgumentError catch (err) {
      LogUtil.d(err);
      ToastUtil.show(err.message.toString());
    } catch (err) {
      LogUtil.d(err);
      if (err.toString().isNotEmpty) {
        ToastUtil.show(err.toString());
      }
    } finally {
      loadingStop();
    }
  }

  void onReceiveClick() {
    Get.bottomSheet(const ReceivingTokensBottomSheet());
  }

  void changeCurrency(String value) {
    sendCurrency.value = value;
  }

  Future<void> addActivity(ActivityModel model) {
    return Future<void>(() {
      var item = storage?.getItem(
        Constant.KEY_ACTIVITIES,
      ) as List<dynamic>?;
      if (item == null) {
        item = [];
      }
      return storage?.setItem(Constant.KEY_ACTIVITIES, [model.toJson(), ...item]);
    });
  }
}
