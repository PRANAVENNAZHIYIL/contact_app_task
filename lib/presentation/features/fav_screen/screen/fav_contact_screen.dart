import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/fav_screen/provider/fav_screen_provider.dart';
import 'package:houzeo_app/presentation/features/fav_screen/widget/fav_contact_title_widget.dart';
import 'package:houzeo_app/presentation/features/fav_screen/widget/fav_contact_widget.dart';
import 'package:houzeo_app/presentation/features/fav_screen/widget/no_fav_widget.dart';
import 'package:houzeo_app/widgets/loading_widget.dart';
import 'package:houzeo_app/widgets/something_went_wrong_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewFavoriteContactsScreen extends StatelessWidget {
  const ViewFavoriteContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ViewFavoriteContactsScreenController>(
        context,
        listen: false);
    return Scaffold(
      body: Consumer<ViewFavoriteContactsScreenController>(
          builder: (context, value, child) {
        return !value.isAleradyFetched
            ? FutureBuilder(
                future: controller.getAllFavoriteContacts(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return FavoriteContactsGridViewWidget(
                          contacts: snapshot.data!);
                    } else {
                      return const SomethingWentWrongWidget();
                    }
                  } else {
                    return const LoadingWidget();
                  }
                },
              )
            : FavoriteContactsGridViewWidget(contacts: value.favoriteContacts);
      }),
    );
  }
}

class FavoriteContactsGridViewWidget extends StatelessWidget {
  final List<ContactModel> contacts;

  const FavoriteContactsGridViewWidget({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return contacts.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const FavoriteContactTitleWidget(),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: Adaptive.w(4.5),
                    vertical: 12,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return FavoriteContactCard(contact: contact);
                  },
                ),
              ),
            ],
          )
        : const NoFavoriteContactsFoundWidget();
  }
}
