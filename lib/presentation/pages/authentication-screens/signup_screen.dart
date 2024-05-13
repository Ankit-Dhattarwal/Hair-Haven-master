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
  bool _isFullNameFilled = false;
  bool _isPhoneNumberFilled = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
  Future<void> sendOTP(String phoneNumber) async {
    final String fullName = _fullNameController.text;
    final String formattedPhoneNumber = '+91$phoneNumber';

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
        final otpUrl = Uri.parse('http://10.0.2.2:6005/api/user/generateotp');

        final otpResponse = await http.get(
          otpUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (otpResponse.statusCode == 200) {
          print('OTP sent successfully');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return const OtpScreen();
              })
          );
        } else {
          print('Failed to send OTP. Status code: ${otpResponse.statusCode}');
          print('Response body: ${otpResponse.body}');
        }
      } else {
        print('Failed to authenticate user. Status code: ${loginResponse
            .statusCode}');
        print('Response body: ${loginResponse.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
    _fullNameController.addListener(_onFullNameChanged);
    _phoneNumberController.addListener(_onPhoneNumberChanged);
  }

  void _onFullNameChanged() {
    setState(() {
      _isFullNameFilled = _fullNameController.text.isNotEmpty;
    });
  }

  void _onPhoneNumberChanged() {
    setState(() {
      _isPhoneNumberFilled = _phoneNumberController.text.isNotEmpty;
    });
  }
  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0),
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
                                  // onChanged: _validatePhoneNumber,
                                ),
                              ),
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
                              Icon(Icons.check_circle_outline, color: Colors
                                  .green,),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'By signing up you agree to the ',
                                          style: TextStyle(color: Colors
                                              .black), // Default text color
                                        ),
                                        TextSpan(
                                          text: 'Terms of service',
                                          style: TextStyle(color: Colors.green
                                              .shade800), // Color for "Terms of service"
                                          // You can also add onTap handler for clicking on "Terms of service"
                                          // onTap: () {
                                          //   // Handle onTap for Terms of service
                                          // },
                                        ),
                                        const TextSpan(
                                          text: ' and ',
                                          style: TextStyle(color: Colors
                                              .black), // Default text color
                                        ),
                                        TextSpan(
                                          text: 'Privacy policy',
                                          style: TextStyle(color: Colors.green
                                              .shade800), // Color for "Privacy policy"
                                          // You can also add onTap handler for clicking on "Privacy policy"
                                          // onTap: () {
                                          //   // Handle onTap for Privacy policy
                                          // },
                                        ),
                                        const TextSpan(
                                          text: '.',
                                          style: TextStyle(color: Colors
                                              .black), // Default text color
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
                    Builder(
                      builder: (context) => TextButton(
                        onPressed: _isFullNameFilled && _isPhoneNumberFilled
                            ? () {
                          // Get the phone number entered by the user
                          String phoneNumber = _phoneNumberController.text;
                          String fullName = _fullNameController.text;
                          if (phoneNumber.length != 10 || !isNumeric(phoneNumber)) {
                            _showMessage('Please enter a valid 10-digit phone number');
                          } else {
                            // Call the sendOTP method with the phone number
                            sendOTP(phoneNumber);
                          }
                        }
                            : null,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyColors.primaryColor),
                            minimumSize:
                            MaterialStateProperty.all(Size(321.w, 38.h)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
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

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}


// void _validatePhoneNumber(String value) {
//     String name = _fullNameController.text;
//     if (name.isEmpty) {
//       _showErrorDialog("Please enter your name.");
//     } else if (value.isEmpty) {
//       _showErrorDialog("Please enter your phone number.");
//     } else if (value.length != 10) {
//       _showErrorDialog("Please enter a 10-digit phone number.");
//     } else {
//       setState(() {
//         _phoneNumberError = null;
//       });
//     }
//   }
//
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Text("Validation Error"),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           ),
//     );
// }

