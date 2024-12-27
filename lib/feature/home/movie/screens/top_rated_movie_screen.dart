part of 'screens.dart';

class TopRatedMovieScreen extends StatefulWidget {
  const TopRatedMovieScreen({super.key});

  @override
  State<TopRatedMovieScreen> createState() => _TopRatedMovieScreenState();
}

class _TopRatedMovieScreenState extends State<TopRatedMovieScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showFab = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    context.read<TopRatedCubit>().topRated(1);
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
    final state = context.read<TopRatedCubit>().state;
    if (state.status == MovieStatusState.loadMore ||
        state.status == MovieStatusState.failure) return;

    final nextPage = state.page + 1;
    context.read<TopRatedCubit>().topRated(nextPage);

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
                        context.read<TopRatedCubit>().reset();
                        Modular.to.pop();
                      },
                      color: AppColor.white,
                    ),
                    middle: const AppText(
                      text: 'Top Rated Movie',
                      size: FontAppSize.font_18,
                      color: AppColor.white,
                      weight: FontAppWeight.medium,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(12),
            BlocBuilder<TopRatedCubit, TopRatedState>(
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
                int items = state.listData.length;
                if (state.page < state.totalPage) {
                  items += 1;
                }

                return Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        _onScroll();
                      }
                      return false;
                    },
                    child: GridView.builder(
                      key: const PageStorageKey('TOP-RATED'),
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      physics: const ClampingScrollPhysics(),
                      itemCount: items,
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
