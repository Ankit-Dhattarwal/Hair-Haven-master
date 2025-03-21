import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hair_haven/core/theme/mycolors.dart';
import 'package:hair_haven/presentation/pages/main_screens/location_screen.dart';
import 'package:hair_haven/presentation/pages/authentication-screens/signup_screen.dart';

import 'ForgetPassword-screens/forget_password_emailVerifacation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.all(34.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/main_logo.png'),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Welcome Back, \nSign in into your account",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: Row(
                          children: [
                            Text(
                              "don't have account?",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignUpScreen();
                                }));
                              },
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: MyColors.primaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintStyle: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'Enter your Password',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintStyle: TextStyle(fontSize: 20.0,fontFamily: 'Poppins',),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordVerification()));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w400,
                                // decoration: TextDecoration.underline
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LocationScreen();
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(MyColors.primaryColor),
                          minimumSize:
                              MaterialStateProperty.all(Size(321.w, 38.h)),
                          shape: MaterialStateProperty.all( RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                        child: Text(
                          "Sign in",
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
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/apple-logo.png',
                                width: 27.w,
                                height: 27.h,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/google.png',
                                width: 27.w,
                                height: 27.h,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/facebook.png',
                                width: 27.w,
                                height: 27.h,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}
