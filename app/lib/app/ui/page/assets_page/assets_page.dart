import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/base/methods.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/page/assets_page/widget/assets_button.dart';
import 'package:app/app/ui/page/assets_page/widget/asset_item.dart';
import 'package:app/app/ui/page/assets_page/widget/send_tokens_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/wallet_account_bottom_sheet.dart';
import 'package:app/app/ui/widget/address_text.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:app/app/ui/widget/trademark_widget.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/jazzicon/jazzicon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetsPage extends GetCommonView<AssetsController> {
  const AssetsPage({super.key});

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 28.86),
          child: GestureDetector(
            onTap: () => onAvatarClick(),
            child: Obx(() {
              return controller.jazziconData.value == null
                  ? SizedBox.fromSize(size: const Size.square(60))
                  : Jazzicon.getIconWidget(controller.jazziconData.value!);
            }),
          ),
        ),
        // Obx(() {
        //   return Jazzicon.getIconWidget(controller.jazziconData.value);
        // }),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            controller.userModel.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AddressText(
                controller.userModel.address,
                style: const TextStyle(
                  fontSize: 14,
                  color: ColorStyle.color_000000_50,
                ),
              ),
              GestureDetector(
                onTap: () => copyAndToast(
                  controller.userModel.address,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Image.asset(
                    R.ASSETS_IMAGES_COPY_PNG,
                    width: 16,
                    height: 16,
                  ),
                ),
              )
            ],
          ),
        ),
        Obx(() {
          if (controller.isContractWallet.value) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30).add(
              const EdgeInsets.only(top: 30),
            ),
            child: Button(
              width: 323,
              height: 54,
              onPressed: () => controller.onActivateMyWallet(),
              data: 'Activate My Wallet',
              borderWidth: 2,
              color: ColorStyle.color_FFF5F5FF,
              fontColor: ColorStyle.color_FF4132FF,
              fontWeight: FontWeight.w500,
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetsButton(
                data: 'Receive',
                image: R.ASSETS_IMAGES_ASSETS_RECEIVE_ICON_PNG,
                onTap: () => controller.onReceiveClick(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: AssetsButton(
                  /// Skyh
                  // await wallet.sendETH() wallet.sendERC20() // weth放资产。。
                  data: 'Send',
                  image: R.ASSETS_IMAGES_ASSETS_SEND_ICON_PNG,
                  onTap: () => onSendClick(),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 38),
          child: Divider(
            height: 1,
            color: ColorStyle.color_4D979797,
          ),
        ),
        Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              LogUtil.d('yjk assets');
              return AssetItem(
                icon: controller.assets[index].icon,
                count:
                    controller.balanceMap[controller.assets[index].address] ??
                        '0.0',
                symbol: controller.assets[index].symbol,
              );
            },
            itemCount: controller.assets.length,
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            SizedBox.expand(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: TopBar(needInfo: true, needScan: true),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => Future.wait([
                        controller.fetchBalance(),
                        controller.fetchWalletContract(),
                      ]),
                      child: _buildBody(context),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 25,
              width: MediaQuery.of(context).size.width,
              child: TradeMarkWidget(),
            ),
          ],
        ),
      ),
    );
  }

  onAvatarClick() {
    Get.bottomSheet(const WalletAccountBottomSheet());
  }

  onSendClick() {
    Get.bottomSheet(
      const SendTokensBottomSheet(),
      isScrollControlled: true,
    );
  }
}
