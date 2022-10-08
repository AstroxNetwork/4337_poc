import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/recover_page/recover_page/widget/recover_qr_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.model,
    required this.isWaiting,
  });

  final String model;
  final bool isWaiting;

  void onClick() {
    Get.bottomSheet(RecoverQRBottomSheet(model: model));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          color: ColorStyle.color_F9F9F9,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model, style: const TextStyle(fontSize: 16)),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: SizedBox(
                width: 70,
                child: Text(
                  isWaiting ? 'waiting' : 'signed',
                  style: TextStyle(
                    fontSize: 16,
                    color: isWaiting
                        ? ColorStyle.color_FFAB21
                        : ColorStyle.color_54A000,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
