import 'dart:async';

import 'package:flutter/material.dart';

import '../../main/main_page.dart';
import '../../../utils/widget/app_scaffold.dart';
import '../../../../utils/constant/app_color.dart';
import '../../../../utils/constant/app_spacing.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MainPage()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isAppbar: AppBarVisibility.off,
      backgroundColor: AppColor.blacklist,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/png/logo.png'),
          ),
          const CircularProgressIndicator(
            color: AppColor.goldenBuddhaBelly,
            strokeWidth: 5.0,
          ),
          const SizedBox(height: AppSpacing.space28),
          Text(
            'Please Wait',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColor.primaryWhite,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
