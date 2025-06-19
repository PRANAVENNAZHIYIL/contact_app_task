import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFiled extends StatelessWidget {
  final Widget? prefix;
  final bool? enabled;
  final int? maxLines;
  final bool? obscureText;
  final Function(String)? onChanged;

  final AsyncSnapshot<dynamic>? errSnapshot;
  final TextCapitalization? textCapitalization;
  final TextEditingController? textEditingController;
  final String? labelText;
  final String? hintText;
  final FilteringTextInputFormatter? filteringTextInputFormatter;
  final LengthLimitingTextInputFormatter? lengthLimitingTextInputFormatter;
  final TextInputType? textInputType;
  final FocusNode? focusNode;

  const InputFiled({
    super.key,
    this.prefix,
    this.enabled,
    this.maxLines,
    this.obscureText,
    this.onChanged,
    this.errSnapshot,
    this.textCapitalization,
    this.textEditingController,
    this.labelText,
    this.filteringTextInputFormatter,
    this.lengthLimitingTextInputFormatter,
    this.textInputType,
    this.hintText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<TextInputFormatter> inputFormatters = [];
    if (filteringTextInputFormatter != null) {
      inputFormatters.add(filteringTextInputFormatter!);
    }
    if (lengthLimitingTextInputFormatter != null) {
      inputFormatters.add(lengthLimitingTextInputFormatter!);
    }

    return TextFormField(
      controller: textEditingController,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      enabled: enabled ?? true,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: size.width * 0.042,
          color: Colors.black,
        ),
        errorText:
            !errSnapshot!.hasError ? null : errSnapshot!.error.toString(),
        errorMaxLines: 3,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
