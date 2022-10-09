import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/page/activities_page/activities_page.dart';
import 'package:app/app/ui/page/assets_page/assets_page.dart';
import 'package:app/app/ui/page/guardians_page/guardians_page.dart';
import 'package:app/app/ui/page/home_page/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends GetCommonView<HomeController> {
  const HomePage({super.key});

  BottomNavigationBarItem tab({
    required String label,
    required String icon,
    required String activeIcon,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Image.asset(
          icon,
          width: 20,
          height: 20,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Image.asset(
          activeIcon,
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: controller.tabIndex,
        children: const [AssetsPage(), ActivitiesPage(), GuardiansPage()],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: ColorStyle.color_80979797,
            ),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.tabIndex,
          selectedFontSize: 12,
          selectedItemColor: Colors.black,
          unselectedFontSize: 12,
          unselectedItemColor: ColorStyle.color_000000_50,
          onTap: (index) => controller.changeTab(index),
          items: [
            tab(
              label: 'Assets',
              icon: R.ASSETS_IMAGES_NAV_ASSETS_PNG,
              activeIcon: R.ASSETS_IMAGES_NAV_ASSETS_ACTIVE_PNG,
            ),
            tab(
              label: 'Activities',
              icon: R.ASSETS_IMAGES_NAV_ACTIVITIES_PNG,
              activeIcon: R.ASSETS_IMAGES_NAV_ACTIVITIES_ACTIVE_PNG,
            ),
            tab(
              label: 'Guardians',
              icon: R.ASSETS_IMAGES_NAV_GUARDIANS_PNG,
              activeIcon: R.ASSETS_IMAGES_NAV_GUARDIANS_ACTIVE_PNG,
            ),
          ],
        ),
      ),
    );
  }
}
