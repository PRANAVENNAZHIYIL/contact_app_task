// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:houzeo_app/data/local_data_base.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/contact_list/provider/view_contact_list_provider.dart';
import 'package:houzeo_app/presentation/features/fav_screen/provider/fav_screen_provider.dart';
import 'package:houzeo_app/routes/profile_nav_params.dart';
import 'package:houzeo_app/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class ViewContactProfileScreenController with ChangeNotifier {
  ProfileNavParams? profiledata;
  Future<void> deleteContact(BuildContext context, ContactModel contact) async {
    try {
      await HouzeoLocalDBFunctions().deleteContact(context, contact.id!);
      successSnackBar(context, "Contact deleted successfully");
      final contactScreenController =
          Provider.of<ViewContactsScreenController>(context, listen: false);
      contactScreenController.allContacts.remove(contact);
      contactScreenController
          .groupedContacts[contact.firstName[0].toUpperCase()]!
          .remove(contact);
      final favoriteController =
          Provider.of<ViewFavoriteContactsScreenController>(context,
              listen: false);
      if (favoriteController.favoriteContacts.contains(contact)) {
        favoriteController.favoriteContacts.remove(contact);
        favoriteController.refreshScreen();
      }
      contactScreenController.refreshScreen();
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);

      errorSnackBar(context, e.toString());
    }
  }

  Future<void> setInitialArgs(
      BuildContext context, ProfileNavParams args) async {
    final contactScreenController =
        Provider.of<ViewContactsScreenController>(context, listen: false);

    await contactScreenController.getAllContacts(context);

    profiledata = args;

    notifyListeners();
  }
}
