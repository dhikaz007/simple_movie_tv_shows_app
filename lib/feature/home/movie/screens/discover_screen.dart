part of 'screens.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showFab = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    context.read<NowPlayingCubit>().nowPlaying(1);
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

  void _onScroll() {
    final state = context.read<NowPlayingCubit>().state;
    if (state.status == MovieStatusState.loadMore ||
        state.status == MovieStatusState.failure) return;

    final nextPage = (state.pagination.page ?? 0) + 1;
    context.read<NowPlayingCubit>().nowPlaying(nextPage);

    print('SCROLLED $nextPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      extendBody: true,
      floatingActionButton: PaginationFAB(
        showFab: _showFab,
        onPressed: () {
          _scrollController.animateTo(
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
              child: Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Modular.to.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColor.white,
                    ),
                  ),
                  const Gap(16),
                  const AppText(
                    text: 'Discover Movie',
                    size: FontAppSize.font_18,
                    color: AppColor.white,
                  ),
                ],
              ),
            ),
            const Gap(12),
            BlocBuilder<NowPlayingCubit, NowPlayingState>(
              builder: (context, state) {
                if (state.status == MovieStatusState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent &&
                          state.status == MovieStatusState.success) {
                        _onScroll();
                      }
                      print('${_showFab.value}');
                      return false;
                    },
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: state.loadMore
                            ? state.listData.length + 1
                            : state.listData.length,
                        separatorBuilder: (context, index) => const Gap(8),
                        itemBuilder: (context, index) {
                          if (index >= state.listData.length) {
                            if (state.status == MovieStatusState.failure) {}
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.white,
                                ),
                              ),
                            );
                          }
                          final movie = state.listData[index];
                          return ListTile(
                            visualDensity: VisualDensity.compact,
                            title: AppText(
                              text: movie.originalTitle ?? '-',
                              size: FontAppSize.font_12,
                              color: AppColor.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
