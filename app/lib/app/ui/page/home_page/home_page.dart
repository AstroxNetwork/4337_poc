import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/activities_page/activities_page.dart';
import 'package:app/app/ui/page/assets_page/assets_page.dart';
import 'package:app/app/ui/page/guardians_page/guardians_page.dart';
import 'package:app/app/ui/page/home_page/home_controller.dart';
import 'package:app/app/ui/page/home_page/widget/home_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends GetCommonView<HomeController> {
  HomePage({super.key});

  final List<Widget> _pageList = [
    const AssetsPage(),
    const ActivitiesPage(),
    const GuardiansPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: controller.tabIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.tabIndex,
        selectedFontSize: 12,
        selectedItemColor: Colors.black,
        unselectedFontSize: 12,
        unselectedItemColor: ColorStyle.color_80000000,
        onTap: (index) => controller.changeTab(index),
        items: [
          tab('Assets'),
          tab('Activities'),
          tab('Guardians'),
        ],
      ),
    );
  }
}
