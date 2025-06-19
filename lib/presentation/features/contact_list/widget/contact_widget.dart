// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/dial_pad/provider/dial_pad_provider.dart';
import 'package:houzeo_app/presentation/features/fav_screen/widget/fav_widget_icon.dart';
import 'package:houzeo_app/routes/profile_nav_params.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContactWidget extends StatelessWidget {
  final ContactModel contact;
  const ContactWidget({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            offset: const Offset(1, 1),
            blurStyle: BlurStyle.outer,
            blurRadius: 2,
            color: backgroundColor.withOpacity(0.14))
      ]),
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(vertical: 5, horizontal: Adaptive.w(3.5)),
        onTap: () async {
          Navigator.pushNamed(context, "/contactProfileScreen",
              arguments: ProfileNavParams(contact: contact));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        leading: CircleAvatar(
          radius: 19.5.sp,
          backgroundColor: contact.profilePic == null
              ? contact.avatarColor!.withOpacity(0.8)
              : Colors.transparent,
          backgroundImage: contact.profilePic != null
              ? MemoryImage(contact.profilePic!)
              : null,
          child: contact.profilePic == null
              ? Text(contact.firstName[0].toUpperCase(),
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: backgroundColor,
                      fontWeight: FontWeight.w600))
              : const SizedBox(),
        ),
        title: Text('${contact.firstName} ${contact.lastName}',
            style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w600)),
        subtitle: Text(contact.phoneNumber,
            style: TextStyle(
                fontSize: 15.sp,
                color: subTextColor,
                fontWeight: FontWeight.w500)),
        trailing: FavoriteWidgetIconButton(
            icon: Icons.phone,
            onPressed: () {
              Provider.of<DialPadScreenController>(context, listen: false)
                  .makeCall(context, contact.phoneNumber);
            },
            color: Colors.green),
      ),
    );
  }
}
