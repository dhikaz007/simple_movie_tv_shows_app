part of 'routes.dart';

class AppRoutes extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const SplashScreen(),
      transition: TransitionType.rightToLeft,
    );
    r.child(
      '/onboarding',
      child: (_) => const OnboardingScreen(),
      transition: TransitionType.rightToLeft,
    );

    r.module(
      '/home',
      module: HomeRoutes(),
      transition: TransitionType.rightToLeft,
    );

    r.module(
      '/auth',
      module: AuthRoutes(),
      transition: TransitionType.rightToLeft,
    );

    r.module(
      '/movie',
      module: MovieRoutes(),
      transition: TransitionType.downToUp,
    );
  }
}
