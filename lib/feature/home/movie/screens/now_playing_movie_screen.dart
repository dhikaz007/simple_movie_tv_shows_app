part of 'screens.dart';

class NowPlayingMovieScreen extends StatefulWidget {
  const NowPlayingMovieScreen({super.key});

  @override
  State<NowPlayingMovieScreen> createState() => _NowPlayingMovieScreenState();
}

class _NowPlayingMovieScreenState extends State<NowPlayingMovieScreen> {
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

    final nextPage = state.pagination.page + 1;
    context.read<NowPlayingCubit>().nowPlaying(nextPage);

    print('SCROLLED $nextPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: true,
      extendBody: true,
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
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: kToolbarHeight),
                  child: NavigationToolbar(
                    leading: BackButton(
                      onPressed: () {
                        context.read<NowPlayingCubit>().reset();
                        Modular.to.pop();
                      },
                      color: AppColor.white,
                    ),
                    middle: const AppText(
                      text: 'Now Playing Movie',
                      size: FontAppSize.font_18,
                      color: AppColor.white,
                      weight: FontAppWeight.medium,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(12),
            BlocBuilder<NowPlayingCubit, NowPlayingState>(
              builder: (context, state) {
                if (state.status == MovieStatusState.loading) {
                  return Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      physics: const ClampingScrollPhysics(),
                      itemCount: 10,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .65,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) => const MovieCardShimmer(),
                    ),
                  );
                }
                return Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent &&
                          state.status == MovieStatusState.success) {
                        _onScroll();
                      }
                      return false;
                    },
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.loadMore
                          ? state.listData.length + 1
                          : state.listData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .65,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        if (index >= state.listData.length) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColor.red),
                              ),
                            ),
                          );
                        }
                        ResultsModel movie = state.listData[index];
                        return InkWell(
                          onTap: () {
                            Modular.to
                                .pushNamed('/movie/detail', arguments: movie);
                          },
                          child: MovieCard(
                            title: movie.originalTitle ?? '-',
                            date: movie.releaseDate ?? DateTime.now(),
                            vote: movie.voteAverage ?? 0.0,
                            poster: movie.posterPath ?? '-',
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
