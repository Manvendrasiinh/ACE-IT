import 'dart:math';

import 'package:ace_it/firebase_options.dart';
import 'package:ace_it/screens/home_screen.dart';
import 'package:ace_it/screens/onboarding_screen.dart';
import 'package:ace_it/widgets/background_container_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> interviewPrepQuotes = [
  "Believe you can and you're halfway there.",
  "Opportunities don't happen, you create them.",
  "Don't watch the clock; do what it does. Keep going.",
  "Hard work beats talent when talent doesn't work hard.",
  "It always seems impossible until it's done.",
  "The best way to predict the future is to create it.",
  "I find that the harder I work, the more luck I seem to have.",
  "Success is not in what you have, but who you are.",
  "Act as if what you do makes a difference. It does.",
  "If you can dream it, you can do it.",
  "The biggest risk is not taking any risk.",
  "Dream big and dare to fail."
];

class CheckOnboarding extends StatefulWidget {
  const CheckOnboarding({super.key});

  @override
  State<CheckOnboarding> createState() => _CheckOnboardingState();
}

class _CheckOnboardingState extends State<CheckOnboarding> {
  final randomQuote =
      interviewPrepQuotes[Random().nextInt(interviewPrepQuotes.length)];

  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 2), () => FlutterNativeSplash.remove());
    Future.delayed(const Duration(seconds: 5), () => checkHasSeen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainerWidget(
        child: Padding(
          padding: EdgeInsets.all(50.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      height: 35.h,
                      child: Image.asset('assets/icons/ic_left_quote.png'))),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  randomQuote,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                      height: 35.h,
                      child: Image.asset('assets/icons/ic_right_quote.png'))),
            ],
          ),
        ),
      ),
    );
  }

  checkHasSeen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool hasSeenOnboarding =
        preferences.getBool('HAS_SEEN_ONBOARDING') ?? false;
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    if (hasSeenOnboarding) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()));
    }
  }
}
