import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:houzeo_app/presentation/features/main_screen/provider/main_screen_provider.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NoFavoriteContactsFoundWidget extends StatelessWidget {
  const NoFavoriteContactsFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: extraPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/fav_data_notfound.svg',
                width: Adaptive.w(70)),
            sizedBoxHeight25,
            Text("No favorite contact found",
                style: TextStyle(fontSize: 15.5.sp)),
            sizedBoxHeight10,
            const AddFavContactButtonWidget()
          ],
        ),
      ),
    );
  }
}

class AddFavContactButtonWidget extends StatelessWidget {
  const AddFavContactButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Provider.of<MainScreenController>(context, listen: false)
          .changeCurrentScreenIndex(1),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonfavcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: const Text(
        'Add Favorite Contacts',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
