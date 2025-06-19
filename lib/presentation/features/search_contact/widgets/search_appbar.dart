import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/search_contact/provider/search_contact_provider.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/widgets/icon_button.dart';

class SearchScreenAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final SearchScreenController controller;
  final TextEditingController textEditingController;
  final List<ContactModel> allContacts;
  const SearchScreenAppBarWidget(
      {super.key,
      required this.controller,
      required this.textEditingController,
      required this.allContacts});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: HouzeoIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          isAppBarBackButton: true,
          icon: Icons.arrow_back),
      title: TextField(
          controller: textEditingController,
          onChanged: (value) {
            controller.search(allContacts, value.toLowerCase());
          },
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
              hintStyle: TextStyle(fontSize: 16),
              hintText: 'Search Contact',
              border: InputBorder.none)),
      elevation: 2,
      shadowColor: blackColor.withOpacity(0.3),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
