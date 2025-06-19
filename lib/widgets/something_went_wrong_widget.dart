import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SomethingWentWrongWidget extends StatelessWidget {
  const SomethingWentWrongWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: extraPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/Something went Wrong.svg',
                width: Adaptive.w(70)),
            sizedBoxHeight25,
            Text("Something went wrong!", style: TextStyle(fontSize: 15.5.sp)),
            sizedBoxHeight03,
            Text("Please try again",
                style: TextStyle(
                    fontSize: 14.6.sp,
                    fontWeight: FontWeight.w400,
                    color: subTextColor)),
          ],
        ),
      ),
    );
  }
}
