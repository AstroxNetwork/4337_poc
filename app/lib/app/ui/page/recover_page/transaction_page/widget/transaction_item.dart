import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/model/data_model.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/recover_page/recover_page/widget/recover_qr_bottom_sheet.dart';
import 'package:app/app/ui/page/recover_page/transaction_page/transaction_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// todo:
class TransactionItem extends GetCommonView<TransactionController> {
  GuardianModel model;

  TransactionItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Padding(
        padding: const EdgeInsets.only(top: 1, bottom: 1),
        child: Container(
          decoration: const BoxDecoration(
            color: ColorStyle.color_F9F9F9,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 12, bottom: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: SizedBox(
                        width: 70,
                        child: Text(
                          'waiting',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorStyle.color_FFAB21,
                          ),
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
    );
  }

  onClick() {
    Get.bottomSheet(
      RecoverQRBottomSheet(
        model: model,
      ),
    );
  }
}
