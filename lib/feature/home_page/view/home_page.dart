import 'package:flutter/material.dart';

import '../../../utils/widget/app_scaffold.dart';
import '../../../utils/constant/app_spacing.dart';
import '../../../utils/constant/app_color.dart';
import '../../search_page/view/search_main.dart';
import 'category_movie/category_movie.dart';
import 'widget/header_title_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isAppbar: AppBarVisibility.on,
      backgroundColor: AppColor.blacklist,
      title: 'Movie List',
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
            TopRatedMovieList(),
            SizedBox(height: AppSpacing.space28),
            HeaderTitleWIdget(title: 'Upcoming'),
            SizedBox(height: AppSpacing.space20),
            UpcomingMovieList(),
            SizedBox(height: AppSpacing.space28),
            HeaderTitleWIdget(title: 'Now Playing'),
            SizedBox(height: AppSpacing.space20),
            NowPlayingMovieList(),
            SizedBox(height: AppSpacing.space28),
            HeaderTitleWIdget(title: 'Popular'),
            SizedBox(height: AppSpacing.space20),
            PopularMovieList(),
          ],
        ),
      ),
    );
  }
}
