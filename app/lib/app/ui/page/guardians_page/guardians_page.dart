import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/ui/page/guardians_page/guardians_controller.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';

class GuardiansPage extends GetCommonView<GuardiansController> {
  const GuardiansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: TopBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
