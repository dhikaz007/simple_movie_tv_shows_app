part of 'screens.dart';

class TvShowsScreen extends StatelessWidget {
  const TvShowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppText(
        text: 'TV SHOWS',
        size: FontAppSize.font_20,
        weight: FontAppWeight.bold,
        color: AppColor.white,
      ),
    );
  }
}
