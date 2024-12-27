part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: true,
      body: DefaultBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: kToolbarHeight),
                  child: NavigationToolbar(
                    leading: PopupMenuButton<String>(
                      icon: SvgPicture.asset(
                        AppIcons.icSearch,
                        colorFilter: const ColorFilter.mode(
                          AppColor.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      color: AppColor.white,
                      iconColor: AppColor.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onSelected: (value) {
                        print(value);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'Movies',
                          onTap: () {
                            Modular.to.pushNamed('/movie/search');
                          },
                          child: const AppText(
                            text: 'Movies',
                            size: FontAppSize.font_12,
                            color: AppColor.black,
                            weight: FontAppWeight.medium,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'TV',
                          child: AppText(
                            text: 'TV',
                            size: FontAppSize.font_12,
                            color: AppColor.black,
                            weight: FontAppWeight.medium,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'People',
                          child: AppText(
                            text: 'People',
                            size: FontAppSize.font_12,
                            color: AppColor.black,
                            weight: FontAppWeight.medium,
                          ),
                        ),
                      ],
                    ),
                    middle: const AppText(
                      text: 'MovieTime',
                      size: FontAppSize.font_18,
                      weight: FontAppWeight.bold,
                      color: AppColor.red,
                    ),
                    trailing: IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppIcons.icNotification,
                        colorFilter: const ColorFilter.mode(
                          AppColor.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                TabBar(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  dividerColor: Colors.transparent,
                  indicatorColor: AppColor.white,
                  labelColor: AppColor.red,
                  unselectedLabelColor: AppColor.white,
                  tabs: const [
                    Tab(text: 'Movies'),
                    Tab(text: 'TV Shows'),
                  ],
                ),
                const Gap(20),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 1.6,
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      MovieScreen(),
                      TvShowsScreen(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
