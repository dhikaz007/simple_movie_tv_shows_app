import 'package:flutter_modular/flutter_modular.dart';

import '../feature/home/screens/main_screen.dart';

class HomeRoutes extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const MainScreen(),
    );
  }
}
