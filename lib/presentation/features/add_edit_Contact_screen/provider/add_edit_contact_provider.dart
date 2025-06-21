import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:houzeo_app/data/local_data_base.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/validator/add_edit_validator.dart';
import 'package:houzeo_app/presentation/features/contact_list/provider/view_contact_list_provider.dart';
import 'package:houzeo_app/presentation/features/fav_screen/provider/fav_screen_provider.dart';
import 'package:houzeo_app/utils/constants/enums.dart';
import 'package:houzeo_app/widgets/snackbar.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../routes/nav_params.dart';

class AddEditProvider extends ChangeNotifier with AddEditValidator {
  BuildContext? pageContext;
  AddEditNavParams? pageIs;
  List<ContactModel> allContacts = [];

  String? tempProfileImagePath;
  Uint8List? image;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final userFirstName = BehaviorSubject<String>();
  final userLastName = BehaviorSubject<String>();
  final userEmail = BehaviorSubject<String>();
  final userMobileNumber = BehaviorSubject<String>();
  final userCompany = BehaviorSubject<String>();

  Function(String) get changeUserFirstName => userFirstName.sink.add;
  Function(String) get changeUserLastName => userLastName.sink.add;
  Function(String) get changeUserEMail => userEmail.sink.add;
  Function(String) get changeUserMobileNumber => userMobileNumber.sink.add;
  Function(String) get changeUserCompany => userCompany.sink.add;

  Stream<String> get valFirstname =>
      userFirstName.stream.transform(validateFirstName(pageContext!));
  Stream<String> get valLasttname =>
      userLastName.stream.transform(validateLastname(pageContext!));
  Stream<String> get valCompany =>
      userCompany.stream.transform(validateCompany(pageContext!));
  Stream<String> get valEmail =>
      userEmail.stream.transform(validateEmail(pageContext!));
  Stream<String> get valMobileNumber =>
      userMobileNumber.stream.transform(validateMobile(pageContext!));

  Stream<bool> get validateUncessary => Rx.combineLatest2(
        valEmail,
        valEmail,
        (email, emails) => email.isNotEmpty,
      ).startWith(true);

  Stream<bool> get getSubmitButton => Rx.combineLatest3(
      valFirstname, valMobileNumber, validateUncessary, (a, b, c) => true);

  Future<void> setInitialArgs(
      BuildContext context, AddEditNavParams args) async {
    pageIs = args;
    pageContext = context;
    await assignValue();
    notifyListeners();
  }

  Future addContact(
    BuildContext context,
  ) async {
    try {
      final contact = ContactModel(
          firstName: userFirstName.hasValue ? userFirstName.value.trim() : '',
          lastName: userLastName.hasValue ? userLastName.value.trim() : '',
          companyName: userCompany.hasValue ? userCompany.value.trim() : '',
          phoneNumber: userMobileNumber.hasValue ? userMobileNumber.value : '',
          email: userEmail.hasValue ? userEmail.value : '',
          profilePic: image,
          isFavorite: false);
      final id = await HouzeoLocalDBFunctions().addNewContact(context, contact);
      if (id != null) {
        if (context.mounted) {
          successSnackBar(context,
              "${userFirstName.value.trim()} ${userLastName.hasValue ? userLastName.value.trim() : ''} added to contact successfully");
          final contactScreenController =
              Provider.of<ViewContactsScreenController>(context, listen: false);
          contactScreenController.refreshScreen();

          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          errorSnackBar(context, 'Somthing went wrong');
        }
      }
    } catch (e) {
      if (context.mounted) {
        errorSnackBar(context, e.toString());
      }
    }
  }

  Future<void> assignValue() async {
    if (pageIs!.enums == AddOrEdit.edit) {
      if (pageIs!.contactModel!.firstName.isNotEmpty) {
        firstNameController.text = pageIs!.contactModel!.firstName;
        changeUserFirstName(pageIs!.contactModel!.firstName);
      }
      if (pageIs!.contactModel!.lastName != null &&
          pageIs!.contactModel!.lastName!.isNotEmpty) {
        lastNameController.text = pageIs!.contactModel!.lastName!;
        changeUserLastName(pageIs!.contactModel!.lastName ?? '');
      }
      if (pageIs!.contactModel!.companyName != null &&
          pageIs!.contactModel!.companyName!.isNotEmpty) {
        companyNameController.text = pageIs!.contactModel!.companyName!;
        changeUserCompany(pageIs!.contactModel!.companyName ?? '');
      }

      if (pageIs!.contactModel!.phoneNumber.isNotEmpty) {
        phoneController.text = pageIs!.contactModel!.phoneNumber;
        changeUserMobileNumber(pageIs!.contactModel!.phoneNumber);
      }

      if (pageIs!.contactModel!.email!.isNotEmpty) {
        emailController.text = pageIs!.contactModel!.email!;
        changeUserEMail(pageIs!.contactModel!.email ?? '');
      }
      if (pageIs!.contactModel!.profilePic != null &&
          pageIs!.contactModel!.profilePic!.isNotEmpty) {
        image = pageIs!.contactModel!.profilePic;
      }
    }
    notifyListeners();
  }

  Future updateContact(
    BuildContext context,
  ) async {
    final contact = ContactModel(
        firstName: userFirstName.hasValue ? userFirstName.value.trim() : '',
        lastName: userLastName.hasValue ? userLastName.value.trim() : '',
        companyName: userCompany.hasValue ? userCompany.value.trim() : '',
        phoneNumber: userMobileNumber.hasValue ? userMobileNumber.value : '',
        email: userEmail.hasValue ? userEmail.value : '',
        id: pageIs!.contactModel!.id != null &&
                pageIs!.contactModel!.id!.isFinite
            ? pageIs!.contactModel!.id!
            : 0,
        isFavorite: pageIs!.contactModel!.isFavorite,
        profilePic: image);

    try {
      final changedRows =
          await HouzeoLocalDBFunctions().updateContact(context, contact);
      if (changedRows != null && changedRows > 0) {
        if (context.mounted) {
          final contactScreenController =
              Provider.of<ViewContactsScreenController>(context, listen: false);
          final index = contactScreenController.allContacts
              .indexWhere((element) => element.id == contact.id);
          contactScreenController.allContacts[index] = contact;
          final groupedIndex = contactScreenController
              .groupedContacts[contact.firstName[0].toUpperCase()]!
              .indexWhere((element) => element.id == contact.id);
          contactScreenController.groupedContacts[
              contact.firstName[0].toUpperCase()]![groupedIndex] = contact;
          contactScreenController.refreshScreen();
          final fav = Provider.of<ViewFavoriteContactsScreenController>(context,
              listen: false);
          fav.refreshScreen();
          Navigator.pop(context);
          Navigator.pop(context);
          successSnackBar(context, "Contact updated successfully");
        }
      }
    } catch (e) {
      if (context.mounted) {
        errorSnackBar(context, e.toString());
      }
    }
  }

  Future<void> selectUserProfilePhoto(
      BuildContext context, ImageSource imageSource) async {
    if (imageSource == ImageSource.camera) {
      bool isPermissionGiven = await Permission.camera.isGranted;
      if (!isPermissionGiven) await Permission.camera.request();
      if (!await Permission.camera.isGranted) {
        await openAppSettings();
        return;
      }
    } else {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        if (sdkInt >= 33) {
          bool isPermissionGiven = await Permission.mediaLibrary.isGranted;
          if (!isPermissionGiven) await Permission.mediaLibrary.request();
          if (!await Permission.mediaLibrary.isGranted) {
            await openAppSettings();
            return;
          }
        } else {
          bool isPermissionGiven = await Permission.storage.isGranted;
          if (!isPermissionGiven) await Permission.storage.request();
          if (!await Permission.storage.isGranted) {
            await openAppSettings();
            return;
          }
        }
      }
    }

    final tempImage = await ImagePicker().pickImage(source: imageSource);
    if (tempImage == null) return;

    final originalFile = File(tempImage.path);
    final originalBytes = await originalFile.readAsBytes();

    final decoded = img.decodeImage(originalBytes);
    if (decoded == null) return;

    final resized = img.copyResize(decoded, width: 300);
    final compressedBytes = Uint8List.fromList(
      img.encodeJpg(resized, quality: 70),
    );

    tempProfileImagePath = tempImage.path;
    image = compressedBytes;
    if (context.mounted) {
      Navigator.pop(context);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    userFirstName.close();
    userLastName.close();
    userEmail.close();
    userMobileNumber.close();
    userCompany.close();
    firstNameController.dispose();
    lastNameController.dispose();
    companyNameController.dispose();
    phoneController.dispose();
    emailController.dispose();

    super.dispose();
  }
}
