import 'dart:async';

import 'package:flutter/material.dart';

mixin AddEditValidator {
  StreamTransformer<String, String> validateMobile(BuildContext context) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (contactNumber, sink) {
        RegExp regex = RegExp(r"^[6-9]\d{9}$");

        if (contactNumber.isEmpty) {
          sink.addError("number is empty");
        } else if (!regex.hasMatch(contactNumber)) {
          sink.addError("mobile number not valid");
        } else if (contactNumber.length != 10) {
          sink.addError("mobile number not valid");
        } else {
          sink.add(contactNumber);
        }
      });

  StreamTransformer<String, String> validateEmail(BuildContext context) =>
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
        final emailExp =
            RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.(com|org|in)$');

        if (email.isEmpty) {
          sink.add(email);
        } else {
          if (!emailExp.hasMatch(email)) {
            sink.addError("enter valid email");
          } else {
            sink.add(email);
          }
        }
      });

  StreamTransformer<String, String> validateFirstName(BuildContext context) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (firstname, sink) {
        if (firstname.isEmpty) {
        } else {
          sink.add(firstname);
        }
      });

  StreamTransformer<String, String> validateLastname(BuildContext context) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (lastname, sink) {
        if (lastname.isEmpty) {
        } else {
          sink.add(lastname);
        }
      });
  StreamTransformer<String, String> validateCompany(BuildContext context) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (company, sink) {
        if (company.isEmpty) {
        } else {
          sink.add(company);
        }
      });
}
