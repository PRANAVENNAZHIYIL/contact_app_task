import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FavoriteContactTitleWidget extends StatelessWidget {
  const FavoriteContactTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Text('Favorites',
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600)),
    );
  }
}
