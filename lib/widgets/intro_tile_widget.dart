import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroTileWidget extends StatelessWidget {
  final String title;
  final String description;
  const IntroTileWidget({required this.description, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.circle_outlined, size: 15.r),
            SizedBox(width: 10.r),
            Text(title, style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.r),
          child: Text(description, style: theme.textTheme.bodySmall),
        ),
      ],
    );
  }
}
