import 'package:flutter/services.dart';

class ContactModel {
  int? id;
  Uint8List? profilePic;
  final String firstName;
  final String? lastName;
  final String? companyName;
  final String phoneNumber;
  final String? email;
  bool isFavorite;
  Color? avatarColor;

  ContactModel(
      {this.id,
      this.profilePic,
      required this.firstName,
      this.lastName,
      this.companyName,
      required this.phoneNumber,
      this.email,
      required this.isFavorite,
      this.avatarColor});
}
