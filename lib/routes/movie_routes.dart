part of 'routes.dart';

class MovieRoutes extends Module {
  @override
  void routes(r) {
    r.child('/discover', child: (_) => const DiscoverScreen());
    r.child('/detail', child: (_) => MovieDetailScreen(movie: r.args.data));
    r.child(
      '/search',
      child: (_) => const SearchMovieScreen(),
      transition: TransitionType.downToUp,
    );
  }
}
