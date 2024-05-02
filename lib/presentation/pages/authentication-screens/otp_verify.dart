import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hair_haven/presentation/pages/main_screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import '../../../core/theme/mycolors.dart';
import 'package:hair_haven/presentation/pages/main_screens/location_screen.dart';

class OtpScreen extends StatefulWidget {
  final String? mobileNo;
  final String? otpHash;

  const OtpScreen({Key? key, this.mobileNo, this.otpHash}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.green),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Expanded(
          child: Text(
            "Back",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(34.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h,),
                        Center(
                          child: Text("Phone verification",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24.sp
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Center(
                          child: Text("Enter your OTP code",
                            style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.sp,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ),
                        SizedBox(height: 50.h,),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child:  Center(
                            child: Pinput(
                              length: 6,
                              showCursor: true,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              onChanged: (value) {
                                otpController.text = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive code? ",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Resend code logic here
                              },
                              child: Text(
                                "Resend Code",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: MyColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextButton(
                onPressed: () async {
                  final enteredCode = otpController.text;
                  final verifyUrl = Uri.http('10.0.2.2:6005', '/api/user/verifyotp', {'code': enteredCode});

                  final response = await http.get(verifyUrl);
                  if (response.statusCode == 200) {
                    // OTP verification successful, navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  } else {
                    // OTP verification failed, show error message
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('OTP verification failed. Please try again.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyColors.primaryColor),
                  minimumSize: MaterialStateProperty.all(Size(321.w, 38.h)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
