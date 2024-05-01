import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hair_haven/features/authentication/controllers/signup_controller.dart';
import 'package:hair_haven/presentation/pages/authentication-screens/otp_verify.dart';
import 'package:http/http.dart' as http;

import '../../../core/theme/mycolors.dart';
import 'ForgetPassword-screens/forget_password_emailVerifacation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController countryController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

   Gender? _selectedGender;

  Future<void> registerUser() async {
      final String fullName = _fullNameController.text;
      final String email = _emailController.text;
      final String phoneNumber = '+91${_phoneNumberController.text}';
      String? gender;
      if (_selectedGender != null) {
        gender = _selectedGender.toString().split('.').last;
      }

      final url = Uri.parse('http://10.0.2.2:5005/api/user/register');

      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'fullname': fullName,
            'email': email,
            'phone': phoneNumber,
            'gender': gender ?? '',
          }),
        );
        if (response.statusCode == 201) {
          print('User registered successfully');
         // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordVerification()));
        } else {
          print('Failed to register user. Status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Exception occurred: $e');
      }
    }


  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.all(30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/main_logo.png'),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Sign up to your account",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            hintText: "Name",
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "E-Mail",
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 40,
                                child: TextField(
                                  controller: countryController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const Text(
                                "|",
                                style:
                                    TextStyle(fontSize: 33, color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextField(
                                    controller: _phoneNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Phone",
                                ),
                              ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Gender>(
                              value: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  value: Gender.Male,
                                  child: Row(
                                    children: [
                                      Icon(Icons.male),
                                      SizedBox(width: 5),
                                      Text('Male'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: Gender.Female,
                                  child: Row(
                                    children: [
                                      Icon(Icons.female),
                                      SizedBox(width: 5),
                                      Text('Female'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: Gender.Other,
                                  child: Row(
                                    children: [
                                      Icon(Icons.transgender),
                                      SizedBox(width: 5),
                                      Text('Other'),
                                    ],
                                  ),
                                ),
                              ],
                              hint: Text('Gender'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        TextButton(
                          onPressed: () {
                            registerUser();
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context){
                            //       return const OtpScreen();
                            //     })
                            // );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyColors.primaryColor),
                            minimumSize:
                                MaterialStateProperty.all(Size(321.w, 38.h)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            )),
                          ),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80.h,
                              height: 2,
                              color: Colors.black,
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              width: 80.h,
                              height: 2,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign in with",
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 65.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/apple-logo.png',
                                width: 27.w,
                                height: 27.h,
                              ),
                              Image.asset(
                                'assets/google.png',
                                width: 27.w,
                                height: 27.h,
                              ),
                              Image.asset(
                                'assets/facebook.png',
                                width: 27.w,
                                height: 27.h,
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}

enum Gender { Male, Female, Other }