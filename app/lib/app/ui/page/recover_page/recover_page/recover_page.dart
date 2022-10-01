import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/recover_page/recover_page/recover_controller.dart';
import 'package:app/app/ui/page/recover_page/recover_page/widget/recover_item.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RecoverPage extends GetCommonView<RecoverController> {
  RecoverPage({super.key});

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
                    needBack: true,
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
                            'Request more than 50% of the Guardians to Sign Transaction',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 9),
                          child: Text(
                            'Once the guardian signs the transaction, the wallet will recover immediately.',
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorStyle.color_black_60,
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return RecoverItem(
                              model: controller.allData[index],
                            );
                          },
                          itemCount: controller.allData.length,
                          separatorBuilder: (_, index) {
                            return index != controller.allData.length
                                ? const Divider(
                                    height: 1,
                                    color: ColorStyle.color_80979797,
                                  )
                                : Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Select',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorStyle.color_black_60,
                              ),
                            ),
                            TextSpan(
                              text: ' ${controller.selectedData.length} ',
                              style: const TextStyle(
                                fontSize: 18,
                                color: ColorStyle.color_black_60,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(
                              text: 'guardian to send request',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorStyle.color_black_60,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Button(
                          width: double.infinity,
                          height: 61,
                          onPressed: () => Get.toNamed(
                            Routes.transactionPage,
                            arguments: controller.selectedData,
                          ),
                          data: 'Send Request',
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
    );
  }
}
