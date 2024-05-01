
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/user/user_model.dart';
import '../../../Model/user/user_repository.dart';
import '../../../data/respositories/authentication/authentication_respo.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variable
  final hidePassword = true.obs;  // Observable for hiding/showing password
  final privacyPolicy = true.obs; // Observable for privacy policy acceptance
  final email = TextEditingController();  // Controller for email input
  final password = TextEditingController();  // Controller for the password input
  final firstName = TextEditingController();  // Controller for the first name input
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form Key for form validation


  /// --SIGNUP

  Future<void> signup() async{

      if(!signupFormKey.currentState!.validate()){
        return;
      }


      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        email: email.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

    }
  }
