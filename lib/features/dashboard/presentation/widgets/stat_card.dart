import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final List<List<dynamic>> icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HugeIcon(
              icon: icon,
              size: 32.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 8.h),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 4.h),
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}
