import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionType { camera, gallery, exStorage, document }

class CheckPermissions {
  // FormStateCallBack? saveDataFunction;
  static Future<bool> checkCameraPermission(
    BuildContext context,
  ) async {
    bool status = false;
    var permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      return true;
    } else {
      if (Platform.isAndroid) {
        if (context.mounted) {
          showAlertAndroidDialog(
            context,
          );
        }
      } else {
        if (context.mounted) {
          showAlertiosDialog(context);
        }
      }

      status = await checkCameraPermissionStatus();
      if (status) {
        return true;
      }
      return false;
    }
  }

  static Future<bool> checkCameraPermissionStatus() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkGalleryPermission(
    BuildContext context,
  ) async {
    bool status = false;
    dynamic info;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      info = await deviceInfoPlugin.androidInfo;
    }
    var permissionStatus = Platform.isAndroid
        ? (info.version.sdkInt) >= 33
            ? await Permission.mediaLibrary.request()
            : await Permission.storage.request()
        : await Permission.photos.request();
    if (permissionStatus.isGranted) {
      return true;
    } else {
      if (Platform.isAndroid) {
        if (context.mounted) {
          showAlertAndroidDialog(
            context,
          );
        }
      } else {
        if (context.mounted) {
          showAlertiosDialog(
            context,
          );
        }
      }

      status = await checkGalleryPermissionStatus();
      if (status) {
        return true;
      }
      // checkGalleryPermission(context.mounted ? context : context);
      return false;
    }
  }

  static Future<bool> checkGalleryPermissionStatus() async {
    dynamic info;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      info = await deviceInfoPlugin.androidInfo;
    }
    var galleryStatus = Platform.isAndroid
        ? (info.version.sdkInt) >= 33
            ? await Permission.mediaLibrary.status
            : await Permission.storage.status
        : await Permission.photos.status;

    if (galleryStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkExStoragePermission(
      BuildContext context, fina) async {
    bool status = false;
    var permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      return true;
    } else {
      if (Platform.isAndroid) {
        if (context.mounted) {
          showAlertAndroidDialog(
            context,
          );
        }
      } else {
        if (context.mounted) {
          showAlertiosDialog(context);
        }
      }

      status = await checkExStoragePermissionStatus();
      if (status) {
        return true;
      }
      //  checkExStoragePermission(context.mounted ? context : context);
      return false;
    }
  }

  static Future<bool> checkExStoragePermissionStatus() async {
    var exStatus = await Permission.storage.status;
    if (exStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkDocumentPermission(BuildContext context) async {
    bool status = false;
    dynamic info;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      info = await deviceInfoPlugin.androidInfo;
    }
    var permissionStatus = Platform.isAndroid
        ? (info.version.sdkInt) >= 33
            ? await Permission.mediaLibrary.request()
            : await Permission.storage.request()
        : await Permission.photos.request();
    if (permissionStatus.isGranted) {
      return true;
    } else {
      if (Platform.isAndroid) {
        if (context.mounted) {
          showAlertAndroidDialog(
            context,
          );
        }
      } else {
        if (context.mounted) {
          showAlertiosDialog(context);
        }
      }

      status = await checkGalleryPermissionStatus();
      if (status) {
        return true;
      }
      //checkDocumentPermission(context.mounted ? context : context);
      return false;
    }
  }

  static Future<bool> checkDocumentPermissionStatus(
      BuildContext context, fina) async {
    dynamic info;
    bool status = false;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      info = await deviceInfoPlugin.androidInfo;
    }
    var galleryStatus = Platform.isAndroid
        ? (info.version.sdkInt) >= 33
            ? await Permission.mediaLibrary.status
            : await Permission.storage.status
        : await Permission.photos.status;

    if (galleryStatus.isGranted) {
      return true;
    } else {
      if (Platform.isAndroid) {
        if (context.mounted) {
          showAlertAndroidDialog(
            context,
          );
        }
      } else {
        if (context.mounted) {
          showAlertiosDialog(context);
        }
      }
      status = await checkExStoragePermissionStatus();
      if (status) {
        return true;
      }
      //checkDocumentPermission(context.mounted ? context : context);
      return false;
    }
  }
}

showAlertiosDialog(context) {
  //var Dispatch = Provider.of<DispatchProvider>(context, listen: false);
  // final lifecycleWatcher = LifecycleWatcher();
  // final classs = CheckPermissions();
  // classs.saveDataFunction = callBack;
  showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Permission Denied'),
              content: const Text('Allow access to gallery and photos'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text('Settings'),
                    onPressed: () async {
                      await openAppSettings();
                    })
              ]));
}

showAlertAndroidDialog(
  context,
) =>
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Permission denied"),
          content: Text("Allow"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "cancel",
                style: const TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: Text(
                "Settings",
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );

// class LifecycleWatcher extends WidgetsBindingObserver {
//   AppLifecycleState _currentState = AppLifecycleState.resumed;

//   AppLifecycleState get currentState => _currentState;

//   static final LifecycleWatcher _instance = LifecycleWatcher._internal();

//   factory LifecycleWatcher() {
//     return _instance;
//   }

//   LifecycleWatcher._internal() {
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     _currentState = state;
//   }
// }
