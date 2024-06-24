import 'package:ace_it/providers/onboarding_provider.dart';
import 'package:ace_it/widgets/background_container_widget.dart';
import 'package:ace_it/widgets/custom_glass_container.dart';
import 'package:ace_it/widgets/intro_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: Scaffold(
        body: BackgroundContainerWidget(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(30.r),
              child: Consumer<OnboardingProvider>(
                builder: (context, state, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACE IT',
                      style: theme.textTheme.titleLarge!
                          .copyWith(letterSpacing: 2.w),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      'Be Prepared, Be Confident.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomGlassContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Image.asset('assets/images/app_logo.png')),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                const IntroTileWidget(
                                    title: 'Personalized Flashcards',
                                    description:
                                        "Access a wide range of flashcards tailored to your learning needs."),
                                SizedBox(height: 8.h),
                                const IntroTileWidget(
                                    title: 'Category-Based Learning',
                                    description:
                                        "Focus on specific categories to strengthen your weak areas."),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: state.isLoading
                                        ? null
                                        : () => _getStarted(context),
                                    child: state.isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                            color: Colors.black54,strokeWidth: 0,
                                          ))
                                        : Text(
                                            'GET STARTED',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _getStarted(BuildContext context) {
    Provider.of<OnboardingProvider>(context, listen: false).getStarted(context);
  }
}
