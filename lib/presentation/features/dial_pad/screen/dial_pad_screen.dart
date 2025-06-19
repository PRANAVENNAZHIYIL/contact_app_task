import 'package:flutter/material.dart';
import 'package:houzeo_app/presentation/features/dial_pad/widgets/call_button.dart';
import 'package:houzeo_app/presentation/features/dial_pad/widgets/dial_button.dart';
import 'package:houzeo_app/presentation/features/dial_pad/widgets/dial_pad_display.dart';
import 'package:houzeo_app/widgets/icon_button.dart';

class DialPadScreen extends StatefulWidget {
  const DialPadScreen({super.key});

  @override
  State<DialPadScreen> createState() => _DialPadScreenState();
}

class _DialPadScreenState extends State<DialPadScreen> {
  String phoneNumber = "";

  final Map<String, String> letters = {
    "1": "",
    "2": "ABC",
    "3": "DEF",
    "4": "GHI",
    "5": "JKL",
    "6": "MNO",
    "7": "PQRS",
    "8": "TUV",
    "9": "WXYZ",
    "0": "+",
    "*": "",
    "#": "",
  };

  void addDigit(String digit) {
    setState(() {
      phoneNumber += digit;
    });
  }

  void deleteDigit() {
    if (phoneNumber.isNotEmpty) {
      setState(() {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      });
    }
  }

  void makeCall() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: HouzeoIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            isAppBarBackButton: true,
            icon: Icons.arrow_back),
      ),
      body: Column(
        children: [
          const Spacer(),
          DialPadDisplayWidget(
              phoneNumber: phoneNumber, onDeletePressed: deleteDigit),
          const SizedBox(height: 40),
          _buildDialPad(),
          const SizedBox(height: 25),
          CallButton(number: phoneNumber),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDialPad() {
    return Column(
      children: [
        _buildDialRow(["1", "2", "3"]),
        _buildDialRow(["4", "5", "6"]),
        _buildDialRow(["7", "8", "9"]),
        _buildDialRow(["*", "0", "#"]),
      ],
    );
  }

  Widget _buildDialRow(List<String> digits) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: digits.map((digit) {
          return DialButtonWidget(
              onPressed: () => addDigit(digit),
              digit: digit,
              subText: letters[digit] ?? "");
        }).toList(),
      ),
    );
  }
}
