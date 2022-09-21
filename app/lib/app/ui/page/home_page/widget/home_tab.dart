import 'package:app/app/res/r.dart';
import 'package:flutter/material.dart';

tab(String label) {
  return BottomNavigationBarItem(
    label: label,
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Image.asset(
        R.assetsImagesNavigationIcon,
        width: 20,
        height: 20,
      ),
    ),
    activeIcon: Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Image.asset(
        R.assetsImagesNavigationActiveIcon,
        width: 20,
        height: 20,
      ),
    ),
  );
}
