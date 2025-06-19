import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FavoriteWidgetIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final Color? color;
  const FavoriteWidgetIconButton(
      {super.key, required this.icon, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color ?? primaryColor,
        size: 20.sp,
      ),
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: whiteColor.withOpacity(0.15),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    );
  }
}
