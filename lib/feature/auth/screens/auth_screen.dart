part of 'screens.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int active = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: AppColor.primary,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(24),
                  const AppText(
                    text: 'Welcome Back',
                    size: FontAppSize.font_36,
                    weight: FontAppWeight.medium,
                    color: AppColor.white,
                  ),
                  const Gap(20),
                  Visibility(
                    visible: active == 0,
                    replacement: const AppText(
                      text: 'To continue, register your account using email',
                      size: FontAppSize.font_16,
                      weight: FontAppWeight.normal,
                      color: AppColor.white,
                    ),
                    child: const AppText(
                      text: 'To continue, log in to your account using email',
                      size: FontAppSize.font_16,
                      weight: FontAppWeight.normal,
                      color: AppColor.white,
                    ),
                  ),
                  const Gap(20),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColor.black2,
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: AppColor.black2,
                        border: const Border(
                          top: BorderSide(color: AppColor.orange),
                          bottom: BorderSide(color: AppColor.orange),
                          left: BorderSide(color: AppColor.orange),
                          right: BorderSide(color: AppColor.orange),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      unselectedLabelColor: AppColor.grey2,
                      labelColor: AppColor.orange,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(
                          text: 'Sign In',
                        ),
                        Tab(
                          text: 'Sign Up',
                        ),
                      ],
                      onTap: (value) => setState(() => active = value),
                    ),
                  ),
                  const Gap(20),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height / 1.7,
                    child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        SignInScreen(),
                        SignUpScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
