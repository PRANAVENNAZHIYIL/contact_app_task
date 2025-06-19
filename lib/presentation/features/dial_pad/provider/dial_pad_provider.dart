// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:houzeo_app/widgets/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

class DialPadScreenController with ChangeNotifier {
  void makeCall(BuildContext context, String number) async {
    var status = await Permission.phone.status;
    if (status.isGranted) {
      try {
        await FlutterPhoneDirectCaller.callNumber(number);
      } catch (e) {
        errorSnackBar(context, "Couldn't call to this number");
      }
    } else {
      openAppSettings();
      errorSnackBar(context, "Give phone access to make calls");
    }
  }
}
