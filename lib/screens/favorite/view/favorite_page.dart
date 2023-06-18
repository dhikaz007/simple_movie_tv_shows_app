import 'package:flutter/material.dart';

import '../../../utils/constant/app_color.dart';
import '../../../utils/widget/app_scaffold.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      isAppbar: AppBarVisibility.on,
      backgroundColor: AppColor.blacklist,
      title: 'Favorite',
    );
  }
}
