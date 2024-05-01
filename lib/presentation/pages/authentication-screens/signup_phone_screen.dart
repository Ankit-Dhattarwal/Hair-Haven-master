// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hair_haven/presentation/pages/authentication-screens/phone_number_login.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../../../core/theme/mycolors.dart';
// class SignUpPhone extends StatefulWidget {
//   const SignUpPhone({super.key});
//
//   @override
//   State<SignUpPhone> createState() => _SignUpPhoneState();
// }
// class _SignUpPhoneState extends State<SignUpPhone> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//
//   Future<void> registerUser() async {
//     if (_formKey.currentState!.validate()) {
//       final String firstName = _firstNameController.text;
//       final String lastName = _lastNameController.text;
//       final String phoneNumber = '+91${_phoneNumberController.text}';
//       final String fullName = '$firstName $lastName';
//
//       final url = Uri.parse('http://10.0.2.2:5005/api/user/register');
//
//       try {
//         final response = await http.post(
//           url,
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(<String, String>{
//             'fullname': fullName,
//             'phone': phoneNumber,
//           }),
//         );
//         if (response.statusCode == 201) {
//           print('User registered successfully');
//            Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneLoginScreen()));
//         } else {
//           print('Failed to register user. Status code: ${response.statusCode}');
//           print('Response body: ${response.body}');
//         }
//       } catch (e) {
//         print('Exception occurred: $e');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: ListView(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(30.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset('assets/main_logo.png'),
//                     SizedBox(height: 20.h,),
//                     Text("Sign up to your account",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600, fontSize: 22.sp
//                       ),
//                     ),
//                     SizedBox(height: 70.h,),
//                     TextFormField(
//                       controller: _firstNameController,
//                       decoration: InputDecoration(
//                         labelText: "First Name",
//                         contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your first name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20.h,),
//                     TextFormField(
//                       controller: _lastNameController,
//                       decoration: InputDecoration(
//                         labelText: "Last Name",
//                         contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your last name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20.h,),
//                     TextFormField(
//                       controller: _phoneNumberController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(width: 1, color: Colors.grey),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         labelText: "Mobile number",
//                         prefixText: '+91 ',
//                         prefixStyle: TextStyle(color: Colors.black),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your phone number';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 30.h,),
//                     TextButton(
//                       onPressed: registerUser,
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(MyColors.primaryColor),
//                         minimumSize: MaterialStateProperty.all(Size(321.w, 38.h)),
//                       ),
//                       child: Text(
//                         "Next",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18.sp,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 80.h,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 80.h,
//                           height: 2,
//                           color: Colors.black,
//                         ),
//                         Text("OR", style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w600
//                         ),),
//                         Container(
//                           width: 80.h,
//                           height: 2,
//                           color: Colors.black,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 50.h,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Sign in with", style: TextStyle(
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w400
//                         ),)
//                       ],
//                     ),
//                     SizedBox(height: 20.h,),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 65.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.asset(
//                             'assets/apple-logo.png',
//                             width: 27.w,
//                             height: 27.h,
//                           ),
//                           Image.asset(
//                             'assets/google.png',
//                             width: 27.w,
//                             height: 27.h,
//                           ),
//                           Image.asset(
//                             'assets/facebook.png',
//                             width: 27.w,
//                             height: 27.h,
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
