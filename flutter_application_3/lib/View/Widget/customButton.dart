import 'package:flutter/material.dart';

import '../../constance.dart';

Widget customButtom({required String text, required Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 55.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
