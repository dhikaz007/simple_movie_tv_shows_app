import 'package:flutter/material.dart';

import 'person_category/popular_person_list.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/widget/app_scaffold.dart';
import '../../../utils/constant/app_spacing.dart';
import '../../home/view/widget/header_title_widget.dart';

class PersonHomePage extends StatelessWidget {
  const PersonHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      isAppbar: AppBarVisibility.on,
      backgroundColor: AppColor.blacklist,
      title: 'Popular People',
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.space20,
          vertical: AppSpacing.space8,
        ),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: AppSpacing.space20),
            HeaderTitleWIdget(title: 'Popular'),
            SizedBox(height: AppSpacing.space20),
            PopularPersonList(),
          ],
        ),
      ),
    );
  }
}
