import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NoResultFoundWidget extends StatelessWidget {
  const NoResultFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: extraPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/noDataFound.svg', width: Adaptive.w(70)),
            sizedBoxHeight25,
            Text("Sorry we couldn't find a user with that name or phone number",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.5.sp)),
          ],
        ),
      ),
    );
  }
}
