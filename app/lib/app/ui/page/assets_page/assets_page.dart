import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/page/assets_page/widget/activate_wallet_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/assets_button.dart';
import 'package:app/app/ui/page/assets_page/widget/asset_item.dart';
import 'package:app/app/ui/page/assets_page/widget/receivingt_tokens_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/wallet_account_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/without_wallet_dialog.dart';
import 'package:app/app/ui/widget/address_text.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// todo: assets页面如何实现刷新？
class AssetsPage extends GetCommonView<AssetsController> {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(
                    needInfo: true,
                    needScan: true,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 28.86),
                        child: GestureDetector(
                          onTap: () => onAvatarClick(),
                          child: Image.network(
                            controller.userModel.avatar,
                            errorBuilder: (_, __, ___) => CircleAvatar(
                              radius: 30,
                              child: Image.asset(
                                R.assetsImagesDefaultAvatar,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
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
                              onTap: () => onCopy(),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  R.assetsImagesCopy,
                                  width: 16,
                                  height: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 29),
                        child: Button(
                          width: 323,
                          height: 54,
                          onPressed: () => onActivateMyWallet(),
                          data: 'Activate My Wallet',
                          borderWidth: 2,
                          color: ColorStyle.color_FFF5F5FF,
                          fontColor: ColorStyle.color_FF4132FF,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AssetsButton(
                              data: 'Receive',
                              image: R.assetsImagesReceiveIcon,
                              onTap: () => onReceiveClick(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: AssetsButton(
                                data: 'Send',
                                image: R.assetsImagesSendIcon,
                                onTap: () {},
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return AssetItem(
                            model: controller.userModel.assets[index],
                          );
                        },
                        itemCount: controller.userModel.assets.length,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onAvatarClick() {
    Get.bottomSheet(const WalletAccountBottomSheet());
  }

  onActivateMyWallet() {
    // todo: 不确定这里的条件
    if (controller.userModel.assets.isEmpty) {
      Get.dialog(const WithoutWalletDialog());
    } else {
      Get.bottomSheet(const ActivateWalletBottomSheet());
    }
  }

  onReceiveClick() {
    Get.bottomSheet(const ReceivingTokensBottomSheet());
  }

  onCopy() {
    Clipboard.setData(ClipboardData(
      text: controller.userModel.address,
    ));
  }
}
