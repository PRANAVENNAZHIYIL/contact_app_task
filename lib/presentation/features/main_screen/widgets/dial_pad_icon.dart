import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/colors.dart';

class DialPadIconButton extends StatelessWidget {
  const DialPadIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/DialScreen",
        );
      },
      borderRadius: BorderRadius.circular(100),
      child: Container(
          width: 63,
          height: 63,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurStyle: BlurStyle.outer,
                blurRadius: 2,
                color: dialpadcolor)
          ], color: dialpadcolor, borderRadius: BorderRadius.circular(35)),
          child:
              const Icon(Icons.dialpad_rounded, color: whiteColor, size: 25)),
    );
  }
}
