import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/Widget/customText.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: customText(text: "Account"));
  }
}
