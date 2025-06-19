import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/colors.dart';

class DialPadDisplayWidget extends StatelessWidget {
  final String phoneNumber;
  final Function() onDeletePressed;
  const DialPadDisplayWidget(
      {super.key, required this.phoneNumber, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              phoneNumber.isEmpty ? "Enter Number" : phoneNumber,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 28, color: textColor, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.backspace),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
