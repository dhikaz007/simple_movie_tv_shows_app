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
      () {
        Modular.to.navigate('/onboarding');
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
          text: 'MovieTime',
          size: FontAppSize.font_40,
          weight: FontAppWeight.bold,
          color: AppColor.orange,
        ),
      ),
    );
  }
}
