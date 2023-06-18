import 'package:flutter/material.dart';

import 'category_tv/category_tv.dart';
import '../../../utils/widget/app_scaffold.dart';
import '../../../utils/constant/app_spacing.dart';
import '../../../utils/constant/app_color.dart';
import '../../home_page/view/widget/header_title_widget.dart';
import '../../search_page/view/search_main.dart';

class TVHomePage extends StatelessWidget {
  const TVHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isAppbar: AppBarVisibility.on,
      backgroundColor: AppColor.blacklist,
      title: 'TV List',
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space20),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const SearchMain();
                  },
                ),
              );
            },
            child: const Icon(
              Icons.search,
              color: AppColor.primaryWhite,
            ),
          ),
        ),
      ],
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.space20,
          vertical: AppSpacing.space8,
        ),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: AppSpacing.space20),
            HeaderTitleWIdget(title: 'Top Rated'),
            SizedBox(height: AppSpacing.space20),
            TopRatedTVList(),
            SizedBox(height: AppSpacing.space28),
            HeaderTitleWIdget(title: 'On The Airing'),
            SizedBox(height: AppSpacing.space20),
            OnTheAirTVList(),
            SizedBox(height: AppSpacing.space28),
            HeaderTitleWIdget(title: 'Airing Today'),
            SizedBox(height: AppSpacing.space20),
            AiringTodayTVList(),
            SizedBox(height: AppSpacing.space28),
            HeaderTitleWIdget(title: 'Popular'),
            SizedBox(height: AppSpacing.space20),
            PopularTVList(),
          ],
        ),
      ),
    );
  }
}
