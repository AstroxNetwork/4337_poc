import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/edit_widget.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SendTokensBottomSheet extends GetCommonView<AssetsController> {
  const SendTokensBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 570,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: appThemeData.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Sending Tokens',
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
                    'To',
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
                controller: controller.toController,
                width: 322,
                height: 55,
                hintText: 'address',
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4, top: 40),
                child: Opacity(
                  opacity: 0.4,
                  child: Text(
                    'Token',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 9, right: 4),
              child: SizedBox(
                width: 322,
                height: 55,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F3FF),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(28),
                          bottomLeft: Radius.circular(28),
                        ),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFF979797),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButton(
                            value: controller.sendCurrency.isEmpty
                                ? controller.getCurrencys().first
                                : controller.sendCurrency,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            iconSize: 28,
                            iconEnabledColor: Colors.black,
                            items: _getCurrencys(),
                            onChanged: (value) =>
                                controller.changeCurrency(value),
                            underline: Container(),
                            elevation: 0,
                            dropdownColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    // 输入框
                    Expanded(
                      child: Container(
                        height: 55,
                        decoration: const BoxDecoration(
                          color: Color(0x80BFBFBF),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(28),
                            bottomRight: Radius.circular(28),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(28),
                                bottomRight: Radius.circular(28),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: appThemeData.scaffoldBackgroundColor,
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.inner,
                                )
                              ]),
                          child: TextField(
                            controller: controller.tokenController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            onChanged: (text) {},
                            decoration: InputDecoration(
                              fillColor: Colors.white12,
                              filled: true,
                              hintStyle: const TextStyle(
                                fontSize: 20,
                                color: Color(0xFFB7B7B7),
                                fontStyle: FontStyle.italic,
                              ),
                              border: _getBorder(false),
                              focusedBorder: _getBorder(true),
                              disabledBorder: _getBorder(false),
                              enabledBorder: _getBorder(false),
                              contentPadding: const EdgeInsets.only(
                                  left: 25, top: 16, right: 24, bottom: 15),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Estimated Fee',
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorStyle.color_black_80,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              '0.005 ETH',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorStyle.color_black_80,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                'Normal Speed',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorStyle.color_black_40,
                                ),
                              ),
                            ),
                          ],
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

  onContinue() async {
    LogUtil.d('onContinue');
    await controller.sendTokens();
    Get.back();
  }

  List<DropdownMenuItem> _getCurrencys() {
    List<DropdownMenuItem> list = [];
    for (String currency in controller.getCurrencys()) {
      list.add(
        DropdownMenuItem(
          value: currency,
          child: Text(currency),
        ),
      );
    }
    return list;
  }

  OutlineInputBorder _getBorder(bool isEdit) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      borderSide: BorderSide(
        color: isEdit ? const Color(0xFF979797) : const Color(0xFF979797),
        width: 1,
      ),
    );
  }
}
