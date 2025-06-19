import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/fav_screen/provider/fav_screen_provider.dart';
import 'package:houzeo_app/routes/nav_params.dart';
import 'package:houzeo_app/utils/constants/enums.dart';
import 'package:houzeo_app/widgets/icon_button.dart';
import 'package:provider/provider.dart';

class ViewProfileScreenAppBarWidget extends StatelessWidget {
  final ContactModel contact;
  const ViewProfileScreenAppBarWidget({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: HouzeoIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          isAppBarBackButton: true,
          icon: Icons.arrow_back),
      pinned: true,
      actions: [
        HouzeoIconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/AddEditScreen",
                  arguments: AddEditNavParams(
                      enums: AddOrEdit.edit, contactModel: contact));
            },
            icon: Icons.edit_outlined),
        const SizedBox(width: 5),
        FavoriteButton(contact: contact),
        const SizedBox(width: 5),
        HouzeoIconButton(onPressed: () {}, icon: Icons.settings_outlined),
        const SizedBox(width: 10)
      ],
    );
  }
}

class FavoriteButton extends StatefulWidget {
  final ContactModel contact;
  const FavoriteButton({super.key, required this.contact});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  void initState() {
    _isFavorite = widget.contact.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HouzeoIconButton(
        onPressed: () async {
          final status =
              await Provider.of<ViewFavoriteContactsScreenController>(context,
                      listen: false)
                  .addOrRemoveToFavorite(context, widget.contact, !_isFavorite);
          if (status) {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          }
        },
        icon: _isFavorite ? Icons.star : Icons.star_border);
  }
}
