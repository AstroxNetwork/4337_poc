import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/ui/page/assets_page/assets_controller.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';

class AssetsPage extends GetCommonView<AssetsController> {
  const AssetsPage({super.key});

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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text('Header'),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: getViews(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getViews() {
    List<Widget> list = [];
    for (int i = 0; i < 1; i++) {
      list.add(
        const ListTile(
          title: Text('Body'),
        ),
      );
    }
    return list;
  }
}
