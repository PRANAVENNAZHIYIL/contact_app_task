import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('animations/loading.json', width: Adaptive.w(50)),
          Text('Loading',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
