import 'package:flutter/material.dart';

import '../constant/app_color.dart';

enum AppBarVisibility { on, off }

extension AppbarIndicator on AppBarVisibility {
  bool get valueAppbar {
    switch (this) {
      case AppBarVisibility.on:
        return true;
      case AppBarVisibility.off:
        return false;
    }
  }
}

class AppScaffold extends StatelessWidget {
  final AppBarVisibility isAppbar;
  final Color? backgroundColor;
  final String? title;
  final List<Widget>? actions;
  final Widget? body;
  final Widget? bottomNavigationBar;
  const AppScaffold({
    super.key,
    required this.isAppbar,
    this.backgroundColor,
    this.title,
    this.actions,
    this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: isAppbar.valueAppbar == true
          ? AppBar(
              title: Text(
                title ?? '',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColor.goldenBuddhaBelly,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              actions: actions,
            )
          : null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
