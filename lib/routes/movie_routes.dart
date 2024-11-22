part of 'routes.dart';

class MovieRoutes extends Module {
  @override
  void routes(r) {
    r.child('/discover', child: (_) => const DiscoverScreen());
  }
}
