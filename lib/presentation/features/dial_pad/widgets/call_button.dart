import 'package:flutter/material.dart';
import 'package:houzeo_app/presentation/features/dial_pad/provider/dial_pad_provider.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:provider/provider.dart';

class CallButton extends StatelessWidget {
  final String number;
  const CallButton({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: extraPadding,
      child: ElevatedButton.icon(
        onPressed: () {
          Provider.of<DialPadScreenController>(context, listen: false)
              .makeCall(context, number);
        },
        icon: const Icon(Icons.call, color: whiteColor),
        label: const Text("Call",
            style: TextStyle(fontSize: 18, color: whiteColor)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
