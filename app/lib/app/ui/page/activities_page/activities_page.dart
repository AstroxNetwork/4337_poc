import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/model/activity_model.dart';
import 'package:app/app/ui/page/activities_page/activities_controller.dart';
import 'package:app/app/ui/page/activities_page/widget/activities_item.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/app/extension/datetime_extension.dart';

class ActivitiesPage extends GetCommonView<ActivitiesController> {
  ActivitiesPage({super.key});

  List<ActivityModel> datas = [
    ActivityModel(
      date: DateTime.now(),
      type: ActivityType.Receive,
      address: '0x755555555CbEF',
      count: 42,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now(),
      type: ActivityType.Send,
      address: '0x755555555CbEF',
      count: 58,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now(),
      type: ActivityType.Receive,
      address: '0x755555555CbEF',
      count: 82,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now().calendarBack(1),
      type: ActivityType.Receive,
      address: '0x755555555CbEF',
      count: 42,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now().calendarBack(1),
      type: ActivityType.Send,
      address: '0x755555555CbEF',
      count: 42,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now().calendarBack(1),
      type: ActivityType.Send,
      address: '0x755555555CbEF',
      count: 81,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now().calendarBack(2),
      type: ActivityType.Receive,
      address: '0x755555555CbEF',
      count: 12,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now().calendarBack(2),
      type: ActivityType.Send,
      address: '0x755555555CbEF',
      count: 32,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now().calendarBack(2),
      type: ActivityType.Receive,
      address: '0x755555555CbEF',
      count: 99,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now().calendarBack(3),
      type: ActivityType.Receive,
      address: '0x755555555CbEF',
      count: 42,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now().calendarBack(3),
      type: ActivityType.Send,
      address: '0x755555555CbEF',
      count: 42,
      currency: 'ETF',
    ),
    ActivityModel(
      date: DateTime.now().calendarBack(3),
      type: ActivityType.Receive,
      address: '0x755555555CbEF',
      count: 42,
      currency: 'ETF',
    ),
  ];

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
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(
                    needInfo: true,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      bool isSameDate = true;
                      if (index == 0) {
                        isSameDate = false;
                      } else {
                        isSameDate =
                            datas[index].date.isSameDay(datas[index - 1].date);
                      }
                      if (index == 0 || !(isSameDate)) {
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 9),
                                child: Text(
                                  datas[index].date.isSameDay(DateTime.now())
                                      ? 'Today'
                                      : datas[index].date.getMonthAndDay(),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            ActivitiesItem(
                              model: datas[index],
                            ),
                          ],
                        );
                      } else {
                        return ActivitiesItem(
                          model: datas[index],
                        );
                      }
                    },
                    itemCount: datas.length,
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
