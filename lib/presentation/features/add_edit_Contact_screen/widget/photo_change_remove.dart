// import 'package:flutter/material.dart';
// import 'package:houzeo_app/presentation/features/add_edit_screen/provider/add_edit_provider.dart';
// import 'package:houzeo_app/utils/constants/colors.dart';
// import 'package:houzeo_app/utils/constants/enums.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class PhotoChangeAndRemoveButton extends StatelessWidget {
//   final AddEditProvider controller;
//   final AddOrEdit? enums;

//   const PhotoChangeAndRemoveButton({
//     super.key,
//     required this.controller,
//     required this.enums,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextButton(
//             onPressed: () {
//               controller.getImageFromresouce(context);
//             },
//             child: Row(
//               children: [
//                 Icon(
//                     enums == AddOrEdit.add
//                         ? Icons.add_photo_alternate_outlined
//                         : Icons.edit_outlined,
//                     size: 17.sp,
//                     color: primaryColor),
//                 const SizedBox(width: 6),
//                 Text(enums == AddOrEdit.add ? 'Uplaod Image' : 'Change',
//                     style: TextStyle(
//                         fontSize: 15.6.sp,
//                         color: primaryColor,
//                         fontWeight: FontWeight.w500))
//               ],
//             )),
//         Visibility(
//           visible: enums == AddOrEdit.edit,
//           child: TextButton(
//               onPressed: () {},
//               child: Row(
//                 children: [
//                   Icon(Icons.delete_outline_outlined,
//                       size: 17.sp, color: primaryColor),
//                   const SizedBox(width: 6),
//                   Text('Remove',
//                       style: TextStyle(
//                           fontSize: 15.6.sp,
//                           color: primaryColor,
//                           fontWeight: FontWeight.w500))
//                 ],
//               )),
//         )
//       ],
//     );
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/provider/add_edit_contact_provider.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/enums.dart';
import 'package:houzeo_app/widgets/pick_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PhotoChangeAndRemoveButton extends StatelessWidget {
  final AddEditProvider controller;
  final AddOrEdit? enums;
  final Uint8List? image;
  const PhotoChangeAndRemoveButton(
      {super.key,
      required this.controller,
      required this.enums,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              SelectImageSourceDialogue().selectImageSourceDialogue(
                  context: context,
                  onCameraSelected: () => controller.selectUserProfilePhoto(
                      context, ImageSource.camera),
                  onGallerySelected: () => controller.selectUserProfilePhoto(
                      context, ImageSource.gallery));
            },
            child: Row(
              children: [
                Icon(
                    enums == AddOrEdit.add || image == null
                        ? Icons.add_photo_alternate_outlined
                        : Icons.edit_outlined,
                    size: 17.sp,
                    color: primaryColor),
                const SizedBox(width: 6),
                Text(
                    enums == AddOrEdit.add || image == null
                        ? 'Uplaod Image'
                        : 'Change',
                    style: TextStyle(
                        fontSize: 15.6.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.w500))
              ],
            )),
        // Visibility(
        //   visible: enums == AddOrEdit.edit && image != null,
        //   child: TextButton(
        //       onPressed: () {},
        //       child: Row(
        //         children: [
        //           Icon(Icons.delete_outline_outlined,
        //               size: 17.sp, color: primaryColor),
        //           const SizedBox(width: 6),
        //           Text('Remove',
        //               style: TextStyle(
        //                   fontSize: 15.6.sp,
        //                   color: primaryColor,
        //                   fontWeight: FontWeight.w500))
        //         ],
        //       )),
        // )
      ],
    );
  }
}
