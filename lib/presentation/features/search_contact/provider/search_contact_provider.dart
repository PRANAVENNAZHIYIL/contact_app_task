import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';

class SearchScreenController with ChangeNotifier {
  List<ContactModel> resultUsers = [];

  void search(List<ContactModel> allContacts, String value) {
    resultUsers.clear();
    for (var contact in allContacts) {
      final bool hasLastName =
          contact.lastName != null || contact.lastName!.isNotEmpty;
      if (contact.firstName.toLowerCase().contains(value) ||
          (hasLastName && contact.lastName!.toLowerCase().contains(value)) ||
          contact.phoneNumber.contains(value)) {
        resultUsers.add(contact);
      }
    }
    notifyListeners();
  }
}
