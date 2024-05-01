import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hair_haven/presentation/pages/main_screens/location_screen.dart';
import 'package:pinput/pinput.dart';
import '../../../core/theme/mycolors.dart';
class OtpScreen extends StatefulWidget {
  final String? mobileNo;
  final String? otpHash;
  const OtpScreen({super.key, this.mobileNo, this.otpHash});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _OtpCode = "";
  final int _OtpCodeLength = 5;
  bool isAPICALLProcess = false;
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
              "Back", // Your title text here
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),

        backgroundColor: Colors.white,
        body: SafeArea(
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
                            length: 5,
                            showCursor: true,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
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
                          TextButton(
                            onPressed: () {
                             ///
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ),
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
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return const LocationScreen();
                      })
                  );
                },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyColors.primaryColor),
                    minimumSize: MaterialStateProperty.all(Size(321.w, 38.h)),
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
        )
    );
  }
}
