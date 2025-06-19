import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/provider/add_edit_contact_provider.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/enums.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SubmitButtonWidget extends StatelessWidget {
  final Stream<bool>? stream;
  final AddOrEdit? enums;
  final AddEditProvider? provider;

  const SubmitButtonWidget(
      {super.key,
      required this.stream,
      required this.enums,
      required this.provider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Adaptive.w(10)),
      child: StreamBuilder<bool>(
          stream: stream,
          builder: (context, snapshot) {
            return Container(
              height: Adaptive.h(5),
              width: Adaptive.w(50),
              decoration: snapshot.hasData ? buttonBoxDecoation : null,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    backgroundColor: submitButton,
                    shadowColor: baseColor),
                onPressed: snapshot.hasData
                    ? () => enums == AddOrEdit.add
                        ? provider!.addContact(context)
                        : provider!.updateContact(context)
                    : null,
                child: Text(enums == AddOrEdit.add ? "Add Contact" : "Update ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: Adaptive.w(5),
                        fontWeight: FontWeight.w600)),
              ),
            );
          }),
    );
  }
}

BoxDecoration buttonBoxDecoation = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    gradient: const LinearGradient(colors: [baseColor, baseColor]));
