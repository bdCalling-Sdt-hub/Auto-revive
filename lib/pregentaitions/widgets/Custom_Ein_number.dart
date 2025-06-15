import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class EINInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Get the raw text without non-digit characters
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Format the input as 'XX-XXXXXXX'
    if (text.length > 2) {
      text = '${text.substring(0, 2)}-${text.substring(2)}';
    }

    // Return the updated TextEditingValue with the formatted text
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}