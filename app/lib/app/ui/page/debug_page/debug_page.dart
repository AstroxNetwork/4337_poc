import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'debug_controller.dart';

class DebugPage extends GetCommonView<DebugController> {
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          title: const Text('ScanPage'),
                          onTap: () => Get.toNamed(Routes.scanPage),
                        ),
                        ListTile(
                          title: const Text('HomePage'),
                          onTap: () => Get.toNamed(Routes.homePage),
                        ),
                        ListTile(
                          title: const Text('HelpPage'),
                          onTap: () => Get.toNamed(
                            Routes.helpPage,
                            arguments:
                                '0x6b5cf860506c6291711478F54123312066946b0',
                          ),
                        )
                      ],
                    ),
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
