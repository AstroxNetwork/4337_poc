import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/model/data_model.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/activities_page/activities_controller.dart';
import 'package:app/app/ui/page/activities_page/widget/activities_item.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/app/extension/datetime_extension.dart';

class ActivitiesPage extends GetCommonView<ActivitiesController> {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ActivityModel> data = controller.datas;
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
                const Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(needInfo: true),
                ),
                if (data.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'No data yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorStyle.color_000000_50,
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final bool isSameDate;
                        if (index == 0) {
                          isSameDate = false;
                        } else {
                          isSameDate =
                              data[index].date.isSameDay(data[index - 1].date);
                        }
                        if (index == 0 || !(isSameDate)) {
                          return Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 9,
                                  ),
                                  child: Text(
                                    data[index].date.isSameDay(DateTime.now())
                                        ? 'Today'
                                        : data[index].date.getMonthAndDay(),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              ActivitiesItem(model: data[index]),
                            ],
                          );
                        }
                        return ActivitiesItem(model: data[index]);
                      },
                      itemCount: data.length,
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
