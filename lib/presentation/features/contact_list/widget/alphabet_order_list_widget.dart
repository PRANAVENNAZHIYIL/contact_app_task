import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'contact_widget.dart';

class AlphabeticOrderListWidget extends StatelessWidget {
  final String alphabet;
  final List<ContactModel> contacts;

  const AlphabeticOrderListWidget({
    super.key,
    required this.alphabet,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: Adaptive.h(1.4),
                  bottom: Adaptive.h(1.4),
                  left: Adaptive.w(1),
                  right: Adaptive.w(4)),
              child: Text(alphabet,
                  style: TextStyle(
                      color: alphabetColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600))),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  ContactWidget(contact: contacts[index]),
              separatorBuilder: (context, index) => sizedBoxHeight10,
              itemCount: contacts.length,
            ),
          )
        ],
      ),
    );
  }
}

class AlphabetOrderListHeaderWidget extends StatelessWidget {
  const AlphabetOrderListHeaderWidget({
    super.key,
    required this.alphabet,
  });

  final String alphabet;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: Adaptive.h(1.4), horizontal: Adaptive.w(2)),
        child: Text(alphabet,
            style: TextStyle(
              color: primaryColor,
              fontSize: 18.5.sp,
              fontWeight: FontWeight.w600,
            )));
  }
}
