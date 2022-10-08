import 'package:flutter/material.dart';

import 'customText.dart';

OutlinedButton customButtonSocial({
  required String text,
  required Function()? onPressed,
  required Widget icon,
}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    onPressed: onPressed,
    child: Row(
      children: [
        icon,
        Expanded(
          child: customText(text: text, textAlign: TextAlign.center),
        ),
      ],
    ),
  );
}
