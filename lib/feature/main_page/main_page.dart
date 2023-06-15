import 'package:flutter/material.dart';

import '../home_page/view/home_main.dart';
import '../person_page/view/person_home_main.dart';
import '../tv_page/view/tv_home_main.dart';
import '../favorite_page/view/favorite_main.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/constant/app_radius.dart';
import '../../utils/widget/app_scaffold.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const List<Widget> _pageIndex = [
    HomeMain(),
    TVHomeMain(),
    PersonHomeMain(),
    FavoriteMain(),
  ];

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> selectedIndex = ValueNotifier(0);

    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, selectedIndexValue, _) {
        return AppScaffold(
          backgroundColor: AppColor.blacklist,
          body: _pageIndex[selectedIndexValue],
          isAppbar: AppBarVisibility.off,
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.radius18),
              topRight: Radius.circular(AppRadius.radius18),
            ),
            child: NavigationBar(
              height: 60,
              selectedIndex: selectedIndexValue,
              indicatorColor: AppColor.windsor,
              backgroundColor: AppColor.corbeau,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              onDestinationSelected: (index) => selectedIndex.value = index,
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.movie,
                    color: AppColor.goldenBuddhaBelly,
                  ),
                  label: 'Movie',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.tv,
                    color: AppColor.goldenBuddhaBelly,
                  ),
                  label: 'Movie',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person_outline,
                    color: AppColor.goldenBuddhaBelly,
                  ),
                  label: 'Movie',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.bookmark,
                    color: AppColor.goldenBuddhaBelly,
                  ),
                  label: 'Movie',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
