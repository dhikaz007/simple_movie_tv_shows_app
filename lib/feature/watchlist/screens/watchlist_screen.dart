part of 'screens.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showFab = ValueNotifier<bool>(false);
  String order = 'created_at.asc';

  @override
  void initState() {
    super.initState();
    context.read<WatchlistCubit>().myWatchlist(page: 1, order: order);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 200) {
        _showFab.value = true;
      } else {
        _showFab.value = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _showFab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      floatingActionButton: PaginationFAB(
        showFab: _showFab,
        onPressed: () async {
          await _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      ),
      body: DefaultBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: kTextTabBarHeight),
                child: const NavigationToolbar(
                  centerMiddle: true,
                  middle: AppText(
                    text: 'My Watchlist',
                    size: FontAppSize.font_18,
                    weight: FontAppWeight.bold,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
            Gap(16),
          ],
        ),
      ),
    );
  }
}
