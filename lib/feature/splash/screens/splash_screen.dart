part of 'screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 1200),
      () async {
        String? isFirstTime = await LocalStorage.getfirstLaunchApp();
        if (isFirstTime == null) {
          Modular.to.navigate('/onboarding');
        } else {
          String? token = await LocalStorage.getAccessToken();
          if (token != null && token.isNotEmpty) {
            Modular.to.navigate('/home/');
          } else {
            Modular.to.navigate('/auth/');
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: AppText(
          text: 'DUMMY',
          size: FontAppSize.font_40,
          weight: FontAppWeight.bold,
          color: AppColor.red,
        ),
      ),
    );
  }
}
