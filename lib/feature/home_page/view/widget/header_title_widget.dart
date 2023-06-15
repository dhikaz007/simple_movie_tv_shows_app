import 'package:flutter/material.dart';

import '../../../../utils/constant/app_color.dart';

class HeaderTitleWIdget extends StatelessWidget {
  final String title;
  const HeaderTitleWIdget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColor.goldenBuddhaBelly,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          'All',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColor.goldenBuddhaBelly,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
