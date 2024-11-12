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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      AppIcons.icSearch,
                      colorFilter: const ColorFilter.mode(
                        AppColor.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const AppText(
                    text: 'MovieTime',
                    size: FontAppSize.font_18,
                    weight: FontAppWeight.bold,
                    color: AppColor.orange,
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      AppIcons.icNotification,
                      colorFilter: const ColorFilter.mode(
                        AppColor.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              TabBar(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Movies'),
                  Tab(text: 'TV Shows'),
                ],
              ),
              const Gap(20),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 2,
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
    );
  }
}
