part of 'shared.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ValueNotifier<int> activeIndex = ValueNotifier(0);

  static final pages = [
    const HomeScreen(),
    const WatchlistScreen(),
    const BookmarkScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: activeIndex,
      builder: (_, __, ___) => Scaffold(
        backgroundColor: AppColor.primary,
        body: IndexedStack(
          index: activeIndex.value,
          children: pages,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColor.grey.withOpacity(.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: NavigationBar(
            selectedIndex: activeIndex.value,
            indicatorShape: null,
            backgroundColor: Colors.transparent,
            elevation: 0,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            indicatorColor: Colors.transparent,
            onDestinationSelected: (value) => activeIndex.value = value,
            destinations: [
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppIcons.icHome,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
                selectedIcon: SvgPicture.asset(
                  AppIcons.icHome,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.orange,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppIcons.icWatchlist,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
                selectedIcon: SvgPicture.asset(
                  AppIcons.icWatchlist,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.orange,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Watchlist',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppIcons.icBookmark,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
                selectedIcon: SvgPicture.asset(
                  AppIcons.icBookmark,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.orange,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Bookmark',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppIcons.icPerson,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
                selectedIcon: SvgPicture.asset(
                  AppIcons.icPerson,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.orange,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
