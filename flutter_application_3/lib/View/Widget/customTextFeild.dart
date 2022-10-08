import 'package:flutter/material.dart';
import 'package:flutter_application_3/constance.dart';

TextFormField customTextFeild({
  required String hint,
  required String? Function(String?)? validator,
  required TextEditingController? controller,
  required String? labelText,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    cursorColor: primaryColor,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey[400],
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[400]!,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      hintText: hint,
    ),
  );
}
