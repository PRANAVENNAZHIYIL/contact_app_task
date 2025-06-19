// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:houzeo_app/data/local_data_base.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/contact_list/provider/view_contact_list_provider.dart';
import 'package:houzeo_app/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class ViewFavoriteContactsScreenController with ChangeNotifier {
  bool isAleradyFetched = false;
  List<ContactModel> favoriteContacts = [];

  Future<List<ContactModel>> getAllFavoriteContacts(
      BuildContext context) async {
    try {
      favoriteContacts.clear();
      final contactsController =
          Provider.of<ViewContactsScreenController>(context, listen: false);
      if (!contactsController.isAlreadyFetched) {
        await contactsController.getAllContacts(context);
      }
      for (var contact in contactsController.allContacts) {
        if (contact.isFavorite) {
          favoriteContacts.add(contact);
        }
      }
      const notFoundSvg = SvgAssetLoader('assets/fav_data_notfound.svg');
      svg.cache.putIfAbsent(
          notFoundSvg.cacheKey(null), () => notFoundSvg.loadBytes(null));
      isAleradyFetched = true;
    } catch (e) {
      errorSnackBar(context, e.toString());
    }
    return favoriteContacts;
  }

  Future<bool> addOrRemoveToFavorite(
      BuildContext context, ContactModel contact, bool isAdd) async {
    try {
      await HouzeoLocalDBFunctions()
          .addOrRemoveToFavorite(context, contact.id!, isAdd);
      final contactScreenController =
          Provider.of<ViewContactsScreenController>(context, listen: false);
      final index = contactScreenController.allContacts
          .indexWhere((element) => element.id == contact.id);
      contactScreenController.allContacts[index].isFavorite =
          isAdd ? true : false;
      final groupedIndex = contactScreenController
          .groupedContacts[contact.firstName[0].toUpperCase()]!
          .indexWhere((element) => element.id == contact.id);
      contactScreenController
          .groupedContacts[contact.firstName[0].toUpperCase()]![groupedIndex]
          .isFavorite = isAdd ? true : false;
      if (isAdd) {
        successSnackBar(context, "Contact added to favorites successfully");
        favoriteContacts.add(contact);
      } else {
        errorSnackBar(context, "Contact removed from favorites successfully");
        favoriteContacts.remove(contact);
      }
      contactScreenController.refreshScreen();
      //contactScreenController.getAllContacts(context);
      refreshScreen();
      return true;
    } catch (e) {
      errorSnackBar(context, e.toString());
      return false;
    }
  }

  void refreshScreen() {
    isAleradyFetched = false;
    notifyListeners();
  }
}
