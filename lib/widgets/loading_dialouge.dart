import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/colors.dart';

class CircularLoadinContainedWidget extends StatelessWidget {
  final double height;
  final double width;
  final double? strokeWidth;
  final double? padding;
  const CircularLoadinContainedWidget(
      {super.key,
      required this.height,
      required this.width,
      this.strokeWidth,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding ?? 8),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                blurRadius: 0.5,
                spreadRadius: 1.5,
                color: blackColor.withOpacity(0.3))
          ]),
      child: CircularProgressIndicator(
          color: primaryColor,
          strokeWidth: strokeWidth ?? 3,
          strokeCap: StrokeCap.round),
    );
  }
}

void showLoadingDialogue(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: const CircularLoadinContainedWidget(height: 10, width: 10),
        ),
      );
    },
  );
}
