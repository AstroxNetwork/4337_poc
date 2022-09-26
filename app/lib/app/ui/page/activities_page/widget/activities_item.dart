import 'package:app/app/extension/datetime_extension.dart';
import 'package:app/app/model/activity_model.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/widget/address_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivitiesItem extends StatelessWidget {
  ActivityModel model;

  ActivitiesItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemClick(context),
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              model.type == ActivityType.Receive
                  ? R.assetsImagesArrowDown
                  : R.assetsImagesArrowUp,
              width: 30,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.type.name.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: ColorStyle.color_black_80,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: SizedBox(
                      width: 69,
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
            Text(
              // todo: 保留几位小数点
              '${model.count} ',
              style: const TextStyle(
                fontSize: 18,
                color: ColorStyle.color_black_80,
              ),
            ),
            Text(
              model.currency,
              style: const TextStyle(
                fontSize: 18,
                color: ColorStyle.color_black_80,
              ),
            )
          ],
        ),
      ),
    );
  }

  onItemClick(BuildContext context) {
    String monthAndDay = model.date.getMonthAndDay();
    Get.bottomSheet(
      Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 14),
                            child: Text(
                              '${model.type.name.toString()} ${model.count.toString()} ${model.currency} on $monthAndDay',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff232323),
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1,
                            color: ColorStyle.color_80979797,
                          ),
                          GestureDetector(
                            // todo: 事件
                            onTap: () {},
                            child: const SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(top: 17, bottom: 16),
                                child: Center(
                                  child: Text(
                                    'View on Etherscan',
                                    style: TextStyle(
                                      color: Color(0xff4693FE),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 25),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 17),
                            child: Text(
                              'Close',
                              style: TextStyle(
                                color: Color(0xff4693FE),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
