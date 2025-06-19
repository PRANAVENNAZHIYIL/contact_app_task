import 'package:flutter/material.dart';

class BottomNavigationBarItemModel {
  final int screenIndex;
  final String title;
  final IconData icon;
  final IconData selectedIcon;

  BottomNavigationBarItemModel(
      {required this.screenIndex,
      required this.title,
      required this.icon,
      required this.selectedIcon});
}
