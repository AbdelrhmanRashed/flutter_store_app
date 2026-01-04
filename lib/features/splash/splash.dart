import 'package:app3/core/resources/app_json.dart';
import 'package:app3/core/resources/cache_helper.dart';
import 'package:app3/features/auth/login/login_screen.dart';
import 'package:app3/features/home/home_screen.dart';
import 'package:app3/features/home_navigation/view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4), () async {
      CacheHelper.getToken().then((value) {
        if (mounted) {
          if (value.isNotEmpty) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeNav(),));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen(),));
          }

        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Lottie.asset(AppJson.splash)),
    );
  }
}
