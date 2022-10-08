import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Model/userModel.dart';
import 'package:flutter_application_3/constance.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  bool isSignUp = true;
  RxBool isSignIn = true.obs;
  UserModel? userModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  loadingSignIn() {
    isSignIn.value = !isSignIn.value;
  }

  loadingSignUp() {
    isSignUp = !isSignUp;
    update();
  }

  // Save DAta User
  saveDataUser(Map<String, dynamic> data) async {
    await firestore
        .collection("users")
        .doc(CachHelper.sharedPreferences!.get("uid").toString())
        .set(data);
  }

  //Sign in With Google
  signInWithGoogle() async {
    return google().then((value) async {
      CachHelper.sharedPreferences!.setString("uid", value.user!.uid);
      userModel = UserModel(
        email: value.user!.email!,
        name: value.user!.displayName!,
        photo: value.user!.photoURL!,
        uid: value.user!.uid,
      );
      await saveDataUser(userModel!.toMap());
      Get.offAllNamed('/home');
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<UserCredential> google() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

// Sign up With Email
  signUpWithEmail(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        userModel = UserModel(
          email: value.user!.email!,
          name: name,
          photo: "",
          uid: value.user!.uid,
        );
        await saveDataUser(userModel!.toMap());
        Get.offAllNamed('/');
      }).catchError((onError) {});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      print(e);
    }
  }

// Sign in With Email
  signInWithEmail({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        CachHelper.sharedPreferences!.setString("uid", value.user!.uid);
        Get.toNamed('/home');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Error",
          'No user found for that email.',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          borderRadius: 0.0,
          margin: const EdgeInsets.all(0),
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Error",
          'Wrong password provided for that user.',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          snackStyle: SnackStyle.FLOATING,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          borderRadius: 0.0,
          margin: const EdgeInsets.all(0),
        );
      }
    }
  }
}
