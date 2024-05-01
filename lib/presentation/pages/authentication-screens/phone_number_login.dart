// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hair_haven/core/theme/mycolors.dart';
// import 'package:hair_haven/presentation/pages/authentication-screens/otp_verify.dart';
// import 'package:http/http.dart' as http;
//
// class PhoneLoginScreen extends StatefulWidget {
//   const PhoneLoginScreen({super.key});
//
//   @override
//   State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
// }
//
// class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
//   String mobileNo = "";
//
//   Future<void> sendVerificationCode(String mobileNumber) async {
//     final url = 'http://10.0.2.2:5005/api/user/generateotp';
//     final completeMobileNumber = '+91 $mobileNumber';
//
//     try {
//       final response = await http.get(Uri.parse('$url?phoneNumber=$completeMobileNumber'));
//       print(completeMobileNumber);
//       if (response.statusCode == 200) {
//         print('OTP sent successfully');
//         Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen()));
//
//       } else {
//         print('Failed to send OTP: ${response.body}');
//       }
//     } catch (e) {
//       print('Exception occurred: $e');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: ListView(
//             children: [
//               Padding(
//                   padding: EdgeInsets.all(34.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.asset('assets/main_logo.png'),
//                       SizedBox(height: 30.h,),
//                       Text("Welcome Back, \nSign in into your account",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600, fontSize: 22.sp
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 30.w),
//                         child: Row(
//                           children: [
//                             Flexible(
//                               child: Text("We need to register your phone berfore getting started!", style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 50.h,),
//                       TextFormField(
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(width: 1, color: Colors.grey),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           labelText: "Mobile number",
//                           prefixText: '+91 ',
//                           prefixStyle: TextStyle(color: Colors.black),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your phone number';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 30.h,),
//                       TextButton(onPressed: () {
//                         sendVerificationCode(mobileNo);
//                       },
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(MyColors.primaryColor),
//                           minimumSize: MaterialStateProperty.all(Size(321.w, 38.h)),
//                         ),
//                         child: Text(
//                           "Send the Otp",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18.sp,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 50.h,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 80.h,
//                             height: 2,
//                             color: Colors.black,
//                           ),
//                           Text("OR", style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600
//                           ),),
//                           Container(
//                             width: 80.h,
//                             height: 2,
//                             color: Colors.black,
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 50.h,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Sign in with", style: TextStyle(
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w400
//                           ),)
//                         ],
//                       ),
//                       SizedBox(height: 20.h,),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 65.w),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                               onPressed: () {  },
//                               icon: Image.asset(
//                                 'assets/apple-logo.png',
//                                 width: 27.w,
//                                 height: 27.h,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {  },
//                               icon: Image.asset(
//                                 'assets/google.png',
//                                 width: 27.w,
//                                 height: 27.h,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: (){},
//                               icon: Image.asset(
//                                 'assets/facebook.png',
//                                 width: 27.w,
//                                 height: 27.h,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   )
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }
//
