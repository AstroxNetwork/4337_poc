import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/recover_page/recover_page/recover_controller.dart';
import 'package:app/app/ui/widget/address_text.dart';
import 'package:app/app/ui/widget/costom_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecoverItem extends GetCommonView<RecoverController> {
  const RecoverItem({super.key, required this.model});

  final String model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 3, top: 20, bottom: 20),
                child: AddressText(
                  model,
                  style: const TextStyle(
                    fontSize: 18,
                    color: ColorStyle.color_black_80,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
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
