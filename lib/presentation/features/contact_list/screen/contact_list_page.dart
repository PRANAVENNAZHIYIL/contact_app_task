// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/contact_list/provider/view_contact_list_provider.dart';
import 'package:houzeo_app/presentation/features/contact_list/widget/alphabet_order_list_widget.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:houzeo_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../widgets/something_went_wrong_widget.dart';
import '../widget/create_new_contact_widget.dart';
import '../widget/no_contact_found_widget.dart';

class ViewContactsScreen extends StatelessWidget {
  const ViewContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller =
        Provider.of<ViewContactsScreenController>(context, listen: false);
    return Scaffold(body: Consumer<ViewContactsScreenController>(
        builder: (context, value, child) {
      _controller.getAllContacts(context);
      return !value.isAlreadyFetched
          ? FutureBuilder(
              future: _controller.getAllContacts(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return ContactsScreenWidget(
                        groupedContacts: snapshot.data!);
                  } else {
                    return const SomethingWentWrongWidget();
                  }
                } else {
                  return const LoadingWidget();
                }
              },
            )
          : ContactsScreenWidget(groupedContacts: value.groupedContacts);
    }));
  }
}

class ContactsScreenWidget extends StatelessWidget {
  final Map<String, List<ContactModel>> groupedContacts;
  const ContactsScreenWidget({super.key, required this.groupedContacts});

  @override
  Widget build(BuildContext context) {
    final List<String> _sortedKeys = groupedContacts.keys.toList()..sort();
    final List<ContactModel> _contacts =
        groupedContacts.values.expand((contacts) => contacts).toList();
    return CustomScrollView(
      slivers: [
        _contacts.isNotEmpty
            ? const CreateNewContactButton()
            : const SliverToBoxAdapter(child: SizedBox()),
        _contacts.isNotEmpty
            ? SliverList.separated(
                itemBuilder: (context, index) {
                  final alphabet = _sortedKeys[index];
                  final contacts = groupedContacts[alphabet] ?? [];
                  return contacts.isNotEmpty
                      ? AlphabeticOrderListWidget(
                          alphabet: alphabet, contacts: contacts)
                      : const SizedBox();
                },
                separatorBuilder: (context, index) {
                  final alphabet = _sortedKeys[index];
                  final contacts = groupedContacts[alphabet] ?? [];
                  return contacts.isNotEmpty
                      ? sizedBoxHeight10
                      : const SizedBox();
                },
                itemCount: groupedContacts.length)
            : const SliverFillRemaining(child: NoContactsFoundWidget()),
        SliverToBoxAdapter(
          child: SizedBox(height: Adaptive.h(12)),
        )
      ],
    );
  }
}
