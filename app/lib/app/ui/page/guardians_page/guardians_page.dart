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
  const GuardiansPage({super.key});

  Widget _buildAddGuardianButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 1, color: ColorStyle.color_80979797),
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
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: TopBar(needInfo: true),
        ),
        Expanded(
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
                  'The guardians help to secure the wallet '
                  'and can sign to recover the wallet when it’s lost.',
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorStyle.color_black_60,
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    if (controller.datas.isEmpty) {
                      return _buildAddGuardianButton(context);
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.datas.length + 1,
                      itemBuilder: (_, index) {
                        if (index == controller.datas.length) {
                          return _buildAddGuardianButton(context);
                        }
                        final model = controller.datas[index];
                        return GuardiansItem(
                          model: model,
                          isAdded: controller.isAdded(model.address),
                          onItemClick: () =>
                              controller.onGuardianItemClick(model),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: _buildBody(context),
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
