import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/model/data_model.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/recover_page/recover_page/recover_controller.dart';
import 'package:app/app/ui/widget/address_text.dart';
import 'package:app/app/ui/widget/costom_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecoverItem extends GetCommonView<RecoverController> {
  GuardianModel model;

  RecoverItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: ColorStyle.color_black_80,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SizedBox(
                      width: 70,
                      child: AddressText(
                        model.address,
                        style: const TextStyle(
                          fontSize: 12,
                          color: ColorStyle.color_black_40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CostomCheckBox(
              size: 25,
              isChecked: controller.selectedData.contains(model),
              checkedColor: ColorStyle.color_FF3940FF,
              animationDuration: const Duration(milliseconds: 200),
              widgetPadding: 0,
              borderColor: controller.selectedData.contains(model)
                  ? ColorStyle.color_FF3940FF
                  : ColorStyle.color_4D979797,
              onTap: (_) {
                controller.toggleCheck(model);
              },
            ),
          ],
        ),
      ),
    );
  }

  onClick() {
    controller.toggleCheck(model);
  }
}
