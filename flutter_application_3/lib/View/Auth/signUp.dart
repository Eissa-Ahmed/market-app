import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/Auth/controller.dart';
import 'package:flutter_application_3/View/Widget/customText.dart';
import 'package:flutter_application_3/constance.dart';
import 'package:get/get.dart';

import '../Widget/customButton.dart';
import '../Widget/customTextFeild.dart';

class SignUp extends GetWidget<AuthController> {
  SignUp({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Card(
                elevation: 3.0,
                shadowColor: Colors.grey[300],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            text: "Sign Up",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/');
                            },
                            child: customText(
                              text: "Sign in",
                              colorFont: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            customTextFeild(
                              hint: "Enter Your Name",
                              controller: nameController,
                              labelText: "Name",
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter Your Name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            customTextFeild(
                              hint: "Enter Your Email",
                              controller: emailController,
                              labelText: "Email",
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter Your Email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            customTextFeild(
                              hint: "Enter Your Password",
                              obscureText: true,
                              controller: passwordController,
                              labelText: "Password",
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter Your Password";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            GetBuilder<AuthController>(
                              builder: (c) => ConditionalBuilder(
                                condition: controller.isSignUp,
                                builder: (context) {
                                  return customButtom(
                                    text: "Sign Up",
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        controller.loadingSignUp();
                                        await controller.signUpWithEmail(
                                          email: emailController!.text,
                                          password: passwordController!.text,
                                          name: nameController!.text,
                                        );
                                        controller.loadingSignUp();
                                      }
                                    },
                                  );
                                },
                                fallback: (context) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
