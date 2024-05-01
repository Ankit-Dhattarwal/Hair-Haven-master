import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hair_haven/presentation/pages/main_screens/location_screen.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/theme/mycolors.dart';
class ForgetPasswordVerification extends StatefulWidget {

  const ForgetPasswordVerification({super.key});

  @override
  State<ForgetPasswordVerification> createState() => _ForgetPasswordVerificationState();
}

class _ForgetPasswordVerificationState extends State<ForgetPasswordVerification> {
  bool isAPICALLProcess = false;
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal:  34.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.h,),
                            Text("Verification email or phone number",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24.sp
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Email or Phone number",
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
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
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                  ),
                  child: Text(
                    "Send OTP",
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
