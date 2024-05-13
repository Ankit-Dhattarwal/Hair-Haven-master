import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hair_haven/presentation/pages/authentication-screens/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication-screens/signup_screen.dart';
import 'authentication-screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      checkFirstTime();
    });
  }

  void checkFirstTime() {
    final storage = GetStorage();
    bool isFirstTime = storage.read('is_first_time') ?? true;
    if (!isFirstTime) {
      /// If not the first time, navigate to the login screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return SignUpScreen();
      }));
    } else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 32.h,
          width: 130.w,
          child: Image.asset(
            'assets/main_logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
