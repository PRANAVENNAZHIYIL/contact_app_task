import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/contact_list/provider/view_contact_list_provider.dart';
import 'package:houzeo_app/presentation/features/contact_list/widget/contact_widget.dart';
import 'package:houzeo_app/presentation/features/contact_list/widget/no_contact_found_widget.dart';
import 'package:houzeo_app/presentation/features/search_contact/provider/search_contact_provider.dart';
import 'package:houzeo_app/presentation/features/search_contact/widgets/no_search_widget.dart';
import 'package:houzeo_app/presentation/features/search_contact/widgets/search_appbar.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchContactScreen extends StatefulWidget {
  const SearchContactScreen({super.key});

  @override
  State<SearchContactScreen> createState() => _SearchContactScreenState();
}

class _SearchContactScreenState extends State<SearchContactScreen> {
  late final SearchScreenController controller;
  List<ContactModel> allContacts = [];
  final searchFieldController = TextEditingController();

  @override
  void initState() {
    controller = Provider.of<SearchScreenController>(context, listen: false);
    allContacts =
        Provider.of<ViewContactsScreenController>(context, listen: false)
            .allContacts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchScreenAppBarWidget(
          allContacts: allContacts,
          controller: controller,
          textEditingController: searchFieldController),
      body: Consumer<SearchScreenController>(builder: (context, value, child) {
        return searchFieldController.text.isEmpty
            ? allContacts.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                        horizontal: Adaptive.w(4.5), vertical: 20),
                    itemBuilder: (context, index) {
                      return ContactWidget(contact: allContacts[index]);
                    },
                    separatorBuilder: (context, index) {
                      return sizedBoxHeight15;
                    },
                    itemCount: allContacts.length)
                : const NoContactsFoundWidget()
            : value.resultUsers.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                        horizontal: Adaptive.w(4.5), vertical: 20),
                    itemBuilder: (context, index) {
                      return ContactWidget(contact: value.resultUsers[index]);
                    },
                    separatorBuilder: (context, index) {
                      return sizedBoxHeight15;
                    },
                    itemCount: value.resultUsers.length)
                : const NoResultFoundWidget();
      }),
    );
  }
}
