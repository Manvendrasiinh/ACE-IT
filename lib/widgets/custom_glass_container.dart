import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class CustomGlassContainer extends StatelessWidget {
  final Widget child;
  const CustomGlassContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassContainer(
        width: double.infinity,
        opacity: 0.4,
        borderRadius: BorderRadius.circular(30.r),
        shadowColor: Colors.black26,
        shadowStrength: 8,
        child: child,
      ),
    );
  }
}
