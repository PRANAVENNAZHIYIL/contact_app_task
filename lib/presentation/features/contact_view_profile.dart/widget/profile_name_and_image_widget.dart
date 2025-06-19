import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileNameAndImageWidget extends StatelessWidget {
  final ContactModel contactModel;
  const ProfileNameAndImageWidget({super.key, required this.contactModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: defaultPadding,
        child: Column(
          children: [
            sizedBoxHeight30,
            CircleAvatar(
              radius: 38.sp,
              backgroundColor: contactModel.profilePic == null
                  ? contactModel.avatarColor!.withOpacity(0.8)
                  : Colors.transparent,
              backgroundImage: contactModel.profilePic != null
                  ? MemoryImage(contactModel.profilePic!)
                  : null,
              child: contactModel.profilePic == null
                  ? Text(
                      contactModel.firstName[0].toUpperCase(),
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: backgroundColor,
                          fontWeight: FontWeight.w400),
                    )
                  : null,
            ),
            sizedBoxHeight25,
            Text(
              '${contactModel.firstName} ${contactModel.lastName}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 21.sp),
            ),
            sizedBoxHeight30
          ],
        ),
      ),
    );
  }
}
