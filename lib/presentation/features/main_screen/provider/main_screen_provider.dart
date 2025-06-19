import 'package:flutter/material.dart';
import 'package:houzeo_app/models/bottom_nav_animated_model.dart';
import 'package:houzeo_app/utils/constants/keys.dart';

class MainScreenController extends ChangeNotifier {
  BuildContext? pageContext;
  int currentScreenIndex = 0;
  int get getSlideindex => currentScreenIndex;
  set setslideIndex(int ind) {
    currentScreenIndex = ind;
    notifyListeners();
  }

  void changeCurrentScreenIndex(int index) {
    if (currentScreenIndex != index) {
      currentScreenIndex = index;
      notifyListeners();
    }
  }

  List<BottomNavBar> bottomNavBar({BuildContext? pageContext}) =>
      pageContext != null
          ? [
              BottomNavBar(
                iconPath: "assets/favourite.svg",
                title: "Favorite",
                dec: "fav_nav",
                globalKey: home,
              ),
              BottomNavBar(
                iconPath: "assets/contact.svg",
                title: "Contact",
                dec: "contact_nav",
                globalKey: call,
              ),
            ]
          : [
              BottomNavBar(),
              BottomNavBar(),
            ];

  List<BottomNavBar> bottomNavBar1 = [
    BottomNavBar(
      iconPath: "assets/favourite.svg",
    ),
    BottomNavBar(
      iconPath: "assets/contact.svg",
    ),
  ];

  initiate(BuildContext context) async {
    pageContext = context;
  }
}
