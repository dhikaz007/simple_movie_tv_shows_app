import 'package:flutter_modular/flutter_modular.dart';

import '../feature/splash/screens/splash_screen.dart';
import 'home_routes.dart';

class AppRoutes extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const SplashScreen(),
      transition: TransitionType.rightToLeft,
    );

    r.module(
      '/home',
      module: HomeRoutes(),
      transition: TransitionType.rightToLeft,
    );
  }
}
