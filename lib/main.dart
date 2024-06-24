import 'package:ace_it/providers/bookmark_provider.dart';
import 'package:ace_it/providers/card_selected_provider.dart';
import 'package:ace_it/providers/flash_card_provider.dart';
import 'package:ace_it/providers/onboarding_provider.dart';
import 'package:ace_it/screens/initialization_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white.withOpacity(0.002),
  ));
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnboardingProvider()),
    ChangeNotifierProvider(create: (context) => CardSelectedProvider()),
    ChangeNotifierProvider(create: (context) => FlashCardProvider()),
    ChangeNotifierProvider(create: (context) => BookmarkProvider())
  ],
  child: const AceIt()));
}

class AceIt extends StatelessWidget {
  const AceIt({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Montserrat',
            appBarTheme: const AppBarTheme(
              elevation: 0
            ),
            splashFactory: NoSplash.splashFactory,
            textTheme: TextTheme(
              titleLarge:
                  TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              titleMedium:
                  TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              titleSmall:
                  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              bodyLarge:
                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(fontSize: 16.sp),
              bodySmall: TextStyle(fontSize: 14.sp),
            ),
          ),
          home: const CheckOnboarding(),
        );
      },
    );
  }
}
