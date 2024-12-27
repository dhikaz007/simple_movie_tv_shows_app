part of 'widgets.dart';

class GenreWidget extends StatelessWidget {
  final Future<dynamic>? future;
  const GenreWidget({super.key, this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GenresShimmer();
        } else if (snapshot.hasData) {
          return GenreChip(listGenre: snapshot.data?.data?.genres ?? []);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
