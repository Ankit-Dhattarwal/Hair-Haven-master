import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hair_haven/features/authentication/controllers/signup_controller.dart';
import 'package:hair_haven/presentation/pages/authentication-screens/otp_verify.dart';
import 'package:http/http.dart' as http;
import '../../../core/theme/mycolors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController countryController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<void> sendOTP(String phoneNumber) async {
    final String fullName = _fullNameController.text;
    final String formattedPhoneNumber = '+91$phoneNumber';

    // First, authenticate the user by making a POST request to /api/user/login
    final loginUrl = Uri.parse('http://10.0.2.2:6005/api/user/login');

    try {
      final loginResponse = await http.post(
        loginUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': formattedPhoneNumber,
        }),
      );

      if (loginResponse.statusCode == 200) {
        // Authentication successful, now make a GET request to /api/user/generateotp
        final otpUrl = Uri.parse('http://10.0.2.2:6005/api/user/generateotp');

        final otpResponse = await http.get(
          otpUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (otpResponse.statusCode == 200) {
          // OTP sent successfully
          print('OTP sent successfully');
          // Navigate to the OTP verification screen or perform any other action here
          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return const OtpScreen();
              })
          );
        } else {
          // Failed to send OTP
          print('Failed to send OTP. Status code: ${otpResponse.statusCode}');
          print('Response body: ${otpResponse.body}');
          // Handle OTP sending failure
        }
      } else {
        // Failed to authenticate user
        print('Failed to authenticate user. Status code: ${loginResponse.statusCode}');
        print('Response body: ${loginResponse.body}');
        // Handle authentication failure
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
      // Handle any exceptions
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
                          "Sign up/Sign In to your account",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 40.h,
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
                          height: 35.h,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle_outline, color: Colors.green,),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'By signing up you agree to the ',
                                          style: TextStyle(color: Colors.black), // Default text color
                                        ),
                                        TextSpan(
                                          text: 'Terms of service',
                                          style: TextStyle(color: Colors.green.shade800), // Color for "Terms of service"
                                          // You can also add onTap handler for clicking on "Terms of service"
                                          // onTap: () {
                                          //   // Handle onTap for Terms of service
                                          // },
                                        ),
                                        const TextSpan(
                                          text: ' and ',
                                          style: TextStyle(color: Colors.black), // Default text color
                                        ),
                                        TextSpan(
                                          text: 'Privacy policy',
                                          style: TextStyle(color: Colors.green.shade800), // Color for "Privacy policy"
                                          // You can also add onTap handler for clicking on "Privacy policy"
                                          // onTap: () {
                                          //   // Handle onTap for Privacy policy
                                          // },
                                        ),
                                        const TextSpan(
                                          text: '.',
                                          style: TextStyle(color: Colors.black), // Default text color
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        TextButton(
                          onPressed: () {
                            // Get the phone number entered by the user
                            String phoneNumber = _phoneNumberController.text;
                            // Call the sendOTP method with the phone number
                            sendOTP(phoneNumber);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyColors.primaryColor),
                            minimumSize:
                                MaterialStateProperty.all(Size(321.w, 38.h)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
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
