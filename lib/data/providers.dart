import 'package:flutter/material.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/provider/add_edit_contact_provider.dart';
import 'package:houzeo_app/presentation/features/contact_list/provider/view_contact_list_provider.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/provider/view_contact_profile_provider.dart';
import 'package:houzeo_app/presentation/features/dial_pad/provider/dial_pad_provider.dart';
import 'package:houzeo_app/presentation/features/fav_screen/provider/fav_screen_provider.dart';
import 'package:houzeo_app/presentation/features/main_screen/provider/main_screen_provider.dart';
import 'package:houzeo_app/presentation/features/search_contact/provider/search_contact_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class HouzeoProviders {
  List<SingleChildWidget> getAllProviders(BuildContext context) {
    return [
      ChangeNotifierProvider(create: (context) => MainScreenController()),
      ChangeNotifierProvider(
          create: (context) => ViewFavoriteContactsScreenController()),
      ChangeNotifierProvider(
          create: (context) => ViewContactsScreenController()),
      ChangeNotifierProvider(create: (context) => SearchScreenController()),
      ChangeNotifierProvider(create: (context) => DialPadScreenController()),
      ChangeNotifierProvider(
          create: (context) => ViewContactProfileScreenController()),
      ChangeNotifierProvider(create: (context) => AddEditProvider()),
    ];
  }
}
