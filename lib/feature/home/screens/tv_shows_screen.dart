part of 'screens.dart';

class TvShowsScreen extends StatelessWidget {
  const TvShowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlatformMenuBar(
      menus: [
        PlatformMenuItem(label: 'Label 1'),
      ],
      child: AppText(
        text: 'PLATFORM',
        size: FontAppSize.font_12,
        color: AppColor.white,
      ),
    );
    // return const Center(
    //   child: AppText(
    //     text: 'TV SHOWS',
    //     size: FontAppSize.font_20,
    //     weight: FontAppWeight.bold,
    //     color: AppColor.white,
    //   ),
    // );
  }
}
