import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/page/assets_page/widget/activate_wallet_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/assets_button.dart';
import 'package:app/app/ui/page/assets_page/widget/assets_item.dart';
import 'package:app/app/ui/page/assets_page/widget/wallet_account_bottom_sheet.dart';
import 'package:app/app/ui/page/assets_page/widget/without_wallet_dialog.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                    isInfo: true,
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
                            '',
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
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Account 1',
                          style: TextStyle(
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
                            const Text(
                              '0x75…CbEF',
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorStyle.color_80000000,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                R.assetsImagesCopy,
                                width: 16,
                                height: 16,
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
                              onTap: () {},
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
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: getViews(),
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

  List<Widget> getViews() {
    List<Widget> list = [];
    for (int i = 0; i < 30; i++) {
      list.add(
        const AssetsItem(),
      );
    }
    return list;
  }

  onAvatarClick() {
    Get.bottomSheet(
      const WalletAccountBottomSheet(),
    );
  }

  onActivateMyWallet() {
    // Get.dialog(
    //   const WithoutWalletDialog(),
    // );
    Get.bottomSheet(
      const ActivateWalletBottomSheet(),
    );
  }
}
