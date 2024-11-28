part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  final String _searchValue = '';

  @override
  void initState() {
    super.initState();
    //context.read<ProfileCubit>().loadProfilte();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: DefaultBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          physics: const ClampingScrollPhysics(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton<String>(
                      initialValue: _searchValue,
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
                    const AppText(
                      text: 'MovieTime',
                      size: FontAppSize.font_18,
                      weight: FontAppWeight.bold,
                      color: AppColor.red,
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
      ),
    );
  }
}
