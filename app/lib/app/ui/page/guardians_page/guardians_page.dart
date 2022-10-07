import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/guardians_page/guardians_controller.dart';
import 'package:app/app/ui/page/guardians_page/widget/add_guardian_bottom_sheet.dart';
import 'package:app/app/ui/page/guardians_page/widget/guardians_item.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuardiansPage extends GetCommonView<GuardiansController> {
  GuardiansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(
                    needInfo: true,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Text(
                            'My Guardians',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 9),
                          child: Text(
                            'The guardians help to secue the wallet and can sign to recover the wallet when it’s lost.',
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorStyle.color_black_60,
                            ),
                          ),
                        ),
                        Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return GuardiansItem(
                                model: controller.datas[index],
                                isAdded: controller.isAdded(controller.datas[index].address),
                                onItemClick: (model){
                                  controller.onGuardianItemClick(model);
                                },
                              );
                            },
                            itemCount: controller.datas.length,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: ColorStyle.color_80979797,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 49, bottom: 49),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Button(
                              width: 200,
                              height: 60,
                              onPressed: () => onAddGuardian(),
                              data: '+ Add Guardians',
                              color: appThemeData.scaffoldBackgroundColor,
                              borderWidth: 2,
                              borderColor: ColorStyle.color_FF3940FF,
                              fontColor: ColorStyle.color_FF3940FF,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onAddGuardian() {
    Get.bottomSheet(
      const AddGuardianBottomSheet(),
      isScrollControlled: true,
    );
  }
}
