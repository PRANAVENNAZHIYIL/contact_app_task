import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/colors.dart';

class HouzeoIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final bool? isAppBarBackButton;
  const HouzeoIconButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.isAppBarBackButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isAppBarBackButton == true
          ? const EdgeInsets.all(8.0)
          : EdgeInsets.zero,
      child: IconButton(
          onPressed: onPressed,
          style: IconButton.styleFrom(
              backgroundColor: cardColor,
              elevation: 2,
              shadowColor: blackColor.withOpacity(0.3)),
          icon: Icon(icon)),
    );
  }
}
