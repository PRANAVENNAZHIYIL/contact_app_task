import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/colors.dart';

class DialButtonWidget extends StatelessWidget {
  final String digit;
  final String subText;
  final Function() onPressed;
  const DialButtonWidget(
      {super.key,
      required this.onPressed,
      required this.digit,
      required this.subText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        height: 80,
        decoration:
            BoxDecoration(color: cardColor, shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              offset: const Offset(1, 1),
              blurStyle: BlurStyle.outer,
              blurRadius: 1,
              color: blackColor.withOpacity(0.15))
        ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(digit,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            if (subText.isNotEmpty)
              Text(subText,
                  style: const TextStyle(fontSize: 12, color: subTextColor)),
          ],
        ),
      ),
    );
  }
}
