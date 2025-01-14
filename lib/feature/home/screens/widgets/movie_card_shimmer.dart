part of 'widgets.dart';

class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppShimmer(
            w: 140,
            h: 220,
            r: 10,
          ),
          Gap(4),
          AppShimmer(
            w: 80,
            h: 16,
            r: 10,
          ),
          Gap(4),
          AppShimmer(
            w: 120,
            h: 16,
            r: 10,
          ),
        ],
      ),
    );
  }
}
