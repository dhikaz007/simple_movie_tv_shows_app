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
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: activeIndex,
      builder: (_, __, ___) => Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.grey,
        body: IndexedStack(
          index: activeIndex.value,
          children: pages,
        ),
        bottomNavigationBar: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: NavigationBar(
            selectedIndex: activeIndex.value,
            indicatorShape: null,
            backgroundColor: AppColor.grey.withAlpha(150),
            elevation: 2,
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
                    AppColor.red,
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
                    AppColor.red,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Watchlist',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppIcons.icFavorite,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
                selectedIcon: SvgPicture.asset(
                  AppIcons.icFavorite,
                  height: 28,
                  width: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColor.red,
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
                    AppColor.red,
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
