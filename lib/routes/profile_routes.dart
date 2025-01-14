part of 'routes.dart';

class ProfileRoutes extends Module {
  @override
  void routes(r) {
    r.child(
      '/lists',
      child: (_) => const MyListsScreen(),
    );
  }
}
