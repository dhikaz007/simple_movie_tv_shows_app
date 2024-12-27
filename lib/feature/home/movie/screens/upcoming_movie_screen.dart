part of 'screens.dart';

class UpcomingMovieScreen extends StatefulWidget {
  const UpcomingMovieScreen({super.key});

  @override
  State<UpcomingMovieScreen> createState() => _UpcomingMovieScreenState();
}

class _UpcomingMovieScreenState extends State<UpcomingMovieScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showFab = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    context.read<UpcomingCubit>().upcoming(1);
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
    final state = context.read<UpcomingCubit>().state;
    if (state.status == MovieStatusState.loadMore ||
        state.status == MovieStatusState.failure) return;

    final nextPage = state.pagination.page + 1;
    context.read<UpcomingCubit>().upcoming(nextPage);

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
                        context.read<UpcomingCubit>().reset();
                        Modular.to.pop();
                      },
                      color: AppColor.white,
                    ),
                    middle: const AppText(
                      text: 'Upcoming Movie',
                      size: FontAppSize.font_18,
                      color: AppColor.white,
                      weight: FontAppWeight.medium,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(12),
            BlocBuilder<UpcomingCubit, UpcomingState>(
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
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        if (!state.loadMore &&
                            state.pagination.page <
                                state.pagination.totalPages) {
                          _onScroll(); // Trigger load more
                        }
                      }
                      return false;
                    },
                    child: GridView.builder(
                      key: const PageStorageKey('TOP-RATED'),
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
