// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:houzeo_app/presentation/features/add_edit_screen/provider/add_edit_provider.dart';
// // import 'package:houzeo_app/utils/constants/colors.dart';
// // import 'package:provider/provider.dart';
// // import 'package:responsive_sizer/responsive_sizer.dart';

// // class AddOrEditProfileScreenCircleAvatarWidget extends StatelessWidget {
// //   final AddEditProvider controller;
// //   const AddOrEditProfileScreenCircleAvatarWidget({
// //     super.key,
// //     required this.controller,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<AddEditProvider>(builder: (context, value, child) {
// //       return GestureDetector(
// //         onTap: () async {
// //           await value.getImageFromresouce(context);
// //         },
// //         child: CircleAvatar(
// //             radius: 33.sp,
// //             backgroundColor: controller.pageIs!.contactModel == null
// //                 ? primaryColor.withOpacity(0.1)
// //                 : controller.pageIs!.contactModel!.avatarColor!
// //                     .withOpacity(0.8),
// //             backgroundImage: value.tempProfileImagePath != null
// //                 ? FileImage(File(value.tempProfileImagePath!))
// //                 : null,
// //             child: value.tempProfileImagePath == null
// //                 ? controller.pageIs!.contactModel != null
// //                     ? Text(
// //                         controller.pageIs!.contactModel!.firstName[0]
// //                             .toUpperCase(),
// //                         style: TextStyle(
// //                             fontSize: 35.sp,
// //                             color: backgroundColor,
// //                             fontWeight: FontWeight.w400))
// //                     : Icon(Icons.add_photo_alternate_outlined,
// //                         color: primaryColor, size: 28.sp)
// //                 : null),
// //       );
// //     });
// //   }
// // }

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:houzeo_app/presentation/features/add_edit_screen/provider/add_edit_provider.dart';
// import 'package:houzeo_app/utils/constants/colors.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class AddOrEditProfileStreamCircleAvatarWidget extends StatelessWidget {
//   final AddEditProvider controller;

//   const AddOrEditProfileStreamCircleAvatarWidget(
//       {super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         await controller.getImageFromresouce(context);
//       },
//       child: StreamBuilder<Uint8List>(
//         stream: controller.valimage,
//         builder: (context, snapshot) {
//           final hasImage = snapshot.hasData && snapshot.data != null;

//           return CircleAvatar(
//             radius: 33.sp,
//             backgroundColor: !hasImage
//                 ? (primaryColor).withOpacity(0.1)
//                 : Colors.transparent,
//             backgroundImage: hasImage ? MemoryImage(snapshot.data!) : null,
//             child: !hasImage
//                 ? (controller.pageIs!.contactModel != null
//                     ? Text(
//                         controller.pageIs!.contactModel!.firstName[0]
//                             .toUpperCase(),
//                         style: TextStyle(
//                           fontSize: 35.sp,
//                           color: backgroundColor,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       )
//                     : Icon(Icons.add_photo_alternate_outlined,
//                         color: primaryColor, size: 28.sp))
//                 : null,
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/provider/add_edit_contact_provider.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/widgets/pick_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddOrEditProfileScreenCircleAvatarWidget extends StatelessWidget {
  final AddEditProvider controller;
  final ContactModel? contact;
  const AddOrEditProfileScreenCircleAvatarWidget(
      {super.key, required this.controller, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEditProvider>(builder: (context, value, child) {
      return GestureDetector(
        onTap: () {
          SelectImageSourceDialogue().selectImageSourceDialogue(
              context: context,
              onCameraSelected: () => controller.selectUserProfilePhoto(
                  context, ImageSource.camera),
              onGallerySelected: () => controller.selectUserProfilePhoto(
                  context, ImageSource.gallery));
        },
        child: CircleAvatar(
            radius: 33.sp,
            backgroundColor: contact == null
                ? primaryColor.withOpacity(0.1)
                : contact!.avatarColor!.withOpacity(0.8),
            backgroundImage: value.tempProfileImagePath != null
                ? FileImage(File(value.tempProfileImagePath!))
                : contact != null
                    ? contact!.profilePic != null
                        ? MemoryImage(contact!.profilePic!)
                        : null
                    : null,
            child: value.tempProfileImagePath == null
                ? contact != null
                    ? Text(contact!.firstName[0].toUpperCase(),
                        style: TextStyle(
                            fontSize: 35.sp,
                            color: backgroundColor,
                            fontWeight: FontWeight.w400))
                    : Icon(Icons.add_photo_alternate_outlined,
                        color: primaryColor, size: 28.sp)
                : null),
      );
    });
  }
}
