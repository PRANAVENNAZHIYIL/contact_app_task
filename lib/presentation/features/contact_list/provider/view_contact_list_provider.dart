import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:houzeo_app/data/local_data_base.dart';
import 'package:houzeo_app/models/contact_model.dart';

class ViewContactsScreenController with ChangeNotifier {
  bool isAlreadyFetched = false;
  List<ContactModel> allContacts = [];
  Map<String, List<ContactModel>> groupedContacts = {};

  Future<Map<String, List<ContactModel>>> getAllContacts(
      BuildContext context) async {
    allContacts = await HouzeoLocalDBFunctions().getAllContacts(context);

    groupedContacts = {
      for (var letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')) letter: []
    };

    for (var i = 0; i < allContacts.length; i++) {
      int colorIndex = (i - 1) % colors.length;
      allContacts[i].avatarColor = colors[colorIndex];
      if (allContacts[i].firstName.isNotEmpty) {
        String firstLetter = allContacts[i].firstName[0].toUpperCase();

        if (groupedContacts.containsKey(firstLetter)) {
          groupedContacts[firstLetter]!.add(allContacts[i]);
        }
      }
    }

    groupedContacts.forEach((key, value) {
      value.sort((a, b) => a.firstName.compareTo(b.firstName));
    });
    const notFoundSvg = SvgAssetLoader('assets/noDataFound.svg');
    svg.cache.putIfAbsent(
        notFoundSvg.cacheKey(null), () => notFoundSvg.loadBytes(null));
    const searchNotFoundSvg = SvgAssetLoader('assets/noDataFound.svg');
    svg.cache.putIfAbsent(searchNotFoundSvg.cacheKey(null),
        () => searchNotFoundSvg.loadBytes(null));
    isAlreadyFetched = true;
    return groupedContacts;
  }

  void refreshScreen() {
    isAlreadyFetched = false;
    notifyListeners();
  }
}

List<Color> colors = [
  const Color.fromARGB(255, 93, 43, 144),
  const Color.fromARGB(255, 245, 194, 26),
  const Color.fromARGB(255, 62, 73, 183),
  const Color.fromARGB(255, 0, 138, 255),
  const Color.fromARGB(255, 250, 65, 38),
  const Color.fromARGB(255, 16, 164, 94),
  const Color.fromARGB(255, 10, 17, 88),
  const Color.fromARGB(255, 255, 97, 128)
];
