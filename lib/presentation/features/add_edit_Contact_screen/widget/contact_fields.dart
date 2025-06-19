import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/widget/input_field.dart';

class FieldsWidget extends StatelessWidget {
  final Size? size;
  final String? type;
  final Stream<String>? stream;
  final Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final bool? requiredField;

  const FieldsWidget({
    super.key,
    this.size,
    this.type,
    this.stream,
    this.onChanged,
    this.textEditingController,
    this.requiredField,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.only(top: size!.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size!.width * 0.025, bottom: size!.width * 0.025),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: size!.width * 0.03,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: "Enter $type"),
                      if (requiredField!)
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size!.width * 0.025),
                child: InputFiled(
                  prefix: const Icon(Icons.add_ic_call_outlined),
                  errSnapshot: snapshot,
                  onChanged: onChanged,
                  textEditingController: textEditingController,
                  hintText: type,
                  filteringTextInputFormatter: FilteringTextInputFormatter(
                    type == "Email"
                        ? RegExp("[A-Za-z0-9][A-Za-z0-9.@]*")
                        : type == "Mobile Number"
                            ? RegExp("[0-9]")
                            : RegExp("[A-Za-z0-9][A-Za-z0-9 ]*"),
                    allow: true,
                  ),
                  lengthLimitingTextInputFormatter:
                      LengthLimitingTextInputFormatter(
                          type == "Mobile Number" ? 10 : 100),
                  textCapitalization: TextCapitalization.words,
                  textInputType: type == "Email"
                      ? TextInputType.emailAddress
                      : type == "Mobile Number"
                          ? TextInputType.number
                          : TextInputType.name,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
