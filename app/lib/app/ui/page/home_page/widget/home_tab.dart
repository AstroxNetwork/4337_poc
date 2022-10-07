import 'package:app/app/res/r.dart';
import 'package:flutter/material.dart';

tab(String label) {
  return BottomNavigationBarItem(
    label: label,
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Image.asset(
        R.ASSETS_IMAGES_NAVIGATION_ICON_PNG,
        width: 20,
        height: 20,
      ),
    ),
    activeIcon: Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Image.asset(
        R.ASSETS_IMAGES_NAVIGATION_ACTIVE_ICON_PNG,
        width: 20,
        height: 20,
      ),
    ),
  );
}
