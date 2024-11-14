part of 'screens.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int activeIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) => setState(() => activeIndex = value),
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.imgOnboarding1),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.imgOnboarding2),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.imgOnboarding3),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: AppColor.primary.withOpacity(.4),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: activeIndex == index
                                  ? AppColor.orange
                                  : AppColor.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                      AppText(
                        text: activeIndex == 0
                            ? 'Welcome to MovieTime'
                            : activeIndex == 1
                                ? 'Enjoy watching on the road'
                                : 'Add to favorites',
                        size: FontAppSize.font_18,
                        weight: FontAppWeight.medium,
                        color: AppColor.white,
                      ),
                      const Gap(8),
                      AppText(
                        text: activeIndex == 0
                            ? 'Watch series and movies in one app based on your preferences'
                            : activeIndex == 1
                                ? 'Download your favorite movies and TV shows to watch them on your journey'
                                : 'Add your favorite movies and TV shows to your favorites to watch them later',
                        size: FontAppSize.font_16,
                        color: AppColor.white,
                        maxLines: 2,
                      ),
                      const Gap(8),
                      ButtonPrimary(
                        label: activeIndex != 2 ? 'Continue' : 'Get Started',
                        onPressed: () {
                          if (activeIndex == 2) {
                            LocalStorage.setfirstLaunchApp();
                            Modular.to.navigate('/auth/');
                          } else {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                          }
                        },
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
