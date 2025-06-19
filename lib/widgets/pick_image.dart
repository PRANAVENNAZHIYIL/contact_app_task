import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectImageSourceDialogue {
  void selectImageSourceDialogue(
      {required BuildContext context,
      required Function() onCameraSelected,
      required Function() onGallerySelected}) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding:
              EdgeInsets.only(bottom: Adaptive.h(3), top: Adaptive.h(2.5)),
          title: Text('Select Image Source',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          children: [
            Padding(
              padding: extraPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      FloatingActionButton(
                          backgroundColor: whiteColor,
                          onPressed: onCameraSelected,
                          child: const Icon(Icons.camera_alt_outlined,
                              color: primaryColor)),
                      sizedBoxHeight10,
                      Text('Camera',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500))
                    ],
                  ),
                  Column(
                    children: [
                      FloatingActionButton(
                          backgroundColor: whiteColor,
                          onPressed: onGallerySelected,
                          child: const Icon(Icons.photo_library_outlined,
                              color: primaryColor)),
                      sizedBoxHeight10,
                      Text('Gallery',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
