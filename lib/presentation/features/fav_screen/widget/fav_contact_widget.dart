// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/dial_pad/provider/dial_pad_provider.dart';
import 'package:houzeo_app/presentation/features/fav_screen/provider/fav_screen_provider.dart';
import 'package:houzeo_app/routes/profile_nav_params.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/widgets/loading_dialouge.dart';
import 'package:provider/provider.dart';

class FavoriteContactCard extends StatelessWidget {
  final ContactModel contact;

  const FavoriteContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/contactProfileScreen",
          arguments: ProfileNavParams(contact: contact),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding:
                const EdgeInsets.only(top: 28, left: 12, right: 12, bottom: 12),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: contact.profilePic == null
                      ? contact.avatarColor!.withOpacity(0.8)
                      : Colors.transparent,
                  backgroundImage: contact.profilePic != null
                      ? MemoryImage(contact.profilePic!)
                      : null,
                  child: contact.profilePic == null
                      ? Text(
                          contact.firstName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  '${contact.firstName} ${contact.lastName}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  contact.phoneNumber,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<DialPadScreenController>(context, listen: false)
                        .makeCall(context, contact.phoneNumber);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7ED348),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size.fromHeight(36),
                  ),
                  child: const Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -12,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () async {
                  final shouldRemove = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Remove from Favorites'),
                      content: const Text(
                          'Would you like to remove this contact from favorites?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Remove'),
                        ),
                      ],
                    ),
                  );

                  if (shouldRemove == true) {
                    showLoadingDialogue(context);
                    await Provider.of<ViewFavoriteContactsScreenController>(
                      context,
                      listen: false,
                    ).addOrRemoveToFavorite(context, contact, false);
                    Navigator.pop(context); // Close the loading dialog
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 255, 166, 82),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
