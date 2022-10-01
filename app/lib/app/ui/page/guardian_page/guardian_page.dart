import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/info/app_theme.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/guardian_page/guardian_controller.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class GuardianPage extends GetCommonView<GuardianController> {
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
                const Padding(
                  padding: EdgeInsets.only(left: 4, top: 25),
                  child: Text(
                    'Guardian Info',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 87, right: 15),
                  child: Card(
                    color: ColorStyle.color_F3F3FF,
                    shadowColor: ColorStyle.color_black_80,
                    elevation: 4,
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.model.name,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: ColorStyle.color_black_80,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: Text(
                                controller.model.address,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: ColorStyle.color_black_80,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4, bottom: 50),
                  child: Button(
                    width: double.infinity,
                    height: 60,
                    onPressed: () {},
                    data: 'Delete',
                    color: appThemeData.scaffoldBackgroundColor,
                    borderWidth: 1,
                    borderColor: ColorStyle.color_FF0000,
                    fontColor: ColorStyle.color_FF0000,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
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
