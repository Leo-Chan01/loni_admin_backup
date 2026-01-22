import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final List<List<dynamic>> icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: icon,
                size: 48.sp,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 12.h),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
