import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/guardians_page/guardians_controller.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGuardianBottomSheet extends GetCommonView<GuardiansController> {
  const AddGuardianBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 570,
      decoration: BoxDecoration(
        color: appThemeData.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                'Add Guardians',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4, top: 39),
                child: Opacity(
                  opacity: 0.4,
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 9, right: 4),
              child: Edit(
                controller: controller.nameController,
                width: 322,
                height: 55,
                hintText: 'name…',
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4, top: 40),
                child: Opacity(
                  opacity: 0.4,
                  child: Text(
                    'Wallet Address',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 9, right: 4),
              child: Edit(
                controller: controller.addressController,
                width: 322,
                height: 55,
                hintText: '0x….',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 49),
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorStyle.color_F5F5F5,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Gas Fee',
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorStyle.color_black_80,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          '0.005 ETH',
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorStyle.color_black_80,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(),
                      width: 112,
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorStyle.color_FF3940FF,
                          ),
                        ),
                      ),
                    ),
                    onTap: () => Get.back(),
                  ),
                  Button(
                    width: 200,
                    height: 60,
                    onPressed: () => onContinue(),
                    data: 'Continue',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onContinue() {
    controller.addGuardian();
    Get.back();
  }
}
