import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/Auth/controller.dart';
import 'package:flutter_application_3/View/Widget/customText.dart';
import 'package:flutter_application_3/constance.dart';
import 'package:get/get.dart';

import '../Widget/customButton.dart';
import '../Widget/customButtonSocial.dart';
import '../Widget/customTextFeild.dart';

// ignore: must_be_immutable
class LogIn extends GetWidget<AuthController> {
  LogIn({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
                            text: "Welcome,",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed("/signup");
                            },
                            child: customText(
                              text: "Sign Up",
                              colorFont: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      customText(
                        text: "Sign in to Continue",
                        colorFont: Colors.grey[600]!,
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
                              hint: "Enter Your Email",
                              controller: emailController,
                              labelText: "Email",
                              validator: (val) {},
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            customTextFeild(
                              hint: "Enter Your Password",
                              obscureText: true,
                              controller: passwordController,
                              labelText: "Password",
                              validator: (val) {},
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: customText(
                                text: "Forget Password ?",
                                colorFont: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GetX<AuthController>(
                              builder: (x) => ConditionalBuilder(
                                condition: controller.isSignIn.value,
                                builder: (context) {
                                  return customButtom(
                                    text: "Sign In",
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        controller.loadingSignIn();
                                        await controller.signInWithEmail(
                                          email: emailController!.text,
                                          password: passwordController!.text,
                                        );
                                        controller.loadingSignIn();
                                      }
                                    },
                                  );
                                },
                                fallback: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              customText(
                text: "-OR-",
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 40,
              ),
              customButtonSocial(
                text: "Sign In with Facebook",
                icon: Image.asset("assets/image/Icon_Facebook.png"),
                onPressed: () async {
                  await controller.signInWithFacebook();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              customButtonSocial(
                text: "Sign In with Google",
                icon: Image.asset("assets/image/icons8_Google_2.png"),
                onPressed: () async {
                  await controller.signInWithGoogle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
