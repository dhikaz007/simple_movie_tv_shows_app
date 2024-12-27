part of 'screens.dart';

class DiscoverMovieScreen extends StatefulWidget {
  const DiscoverMovieScreen({super.key});

  @override
  State<DiscoverMovieScreen> createState() => _DiscoverMovieScreenState();
}

class _DiscoverMovieScreenState extends State<DiscoverMovieScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showFab = ValueNotifier<bool>(false);
  final ValueNotifier<List<Genres>> _listGenre = ValueNotifier([]);
  final ValueNotifier<List<int>> _selectedGenreId = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    context.read<DiscoverCubit>().reset();
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
    _listGenre.dispose();
    _selectedGenreId.dispose();
    super.dispose();
  }

  Future<void> _loadGenres() async {
    try {
      final response = await MovieServices().fetchGenres();
      _listGenre.value = response.data?.genres ?? [];
    } on DioException catch (e) {
      if (!mounted) return;
      AppDialog.showSnackbar(context, e.msgDioErr(), SnackBarStatus.failure);
    }
  }

  void _onScroll(List<int> genre) {
    final state = context.read<DiscoverCubit>().state;
    if (state.status == DiscoverStatus.loadMore ||
        state.status == DiscoverStatus.failure) return;

    final nextPage = state.pagination.page + 1;
    context.read<DiscoverCubit>().discover(page: nextPage, withGenre: genre);

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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: kToolbarHeight),
                child: NavigationToolbar(
                  leading: BackButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    color: AppColor.white,
                  ),
                  middle: const AppText(
                    text: 'Discover Movie',
                    size: FontAppSize.font_18,
                    color: AppColor.white,
                    weight: FontAppWeight.medium,
                  ),
                ),
              ),
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    text: 'Select genres',
                    size: FontAppSize.font_18,
                    color: AppColor.white,
                  ),
                  TextButton(
                    onPressed: () {
                      _selectedGenreId.value = [];
                      context
                          .read<DiscoverCubit>()
                          .discover(withGenre: _selectedGenreId.value, page: 1);
                    },
                    child: const AppText(
                      text: 'Reset Filter',
                      size: FontAppSize.font_14,
                      color: AppColor.red,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(12),
            FutureBuilder(
              future: _loadGenres(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        20,
                        (index) => const RectangleShimmer(w: 60, r: 8),
                      ),
                    ),
                  );
                } else {
                  return ValueListenableBuilder(
                    valueListenable: _listGenre,
                    builder: (context, value, child) => child!,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        children: _listGenre.value.map((e) {
                          return ValueListenableBuilder(
                            valueListenable: _selectedGenreId,
                            builder: (context, idValue, _) => FilterChip(
                              visualDensity: VisualDensity.compact,
                              backgroundColor: AppColor.white,
                              label: AppText(
                                text: e.name ?? '-',
                                size: FontAppSize.font_12,
                                color: idValue.contains(e.id)
                                    ? AppColor.white
                                    : AppColor.black,
                              ),
                              selected: idValue.contains(e.id),
                              color: WidgetStateProperty.resolveWith((state) =>
                                  state.contains(WidgetState.selected)
                                      ? Colors.red
                                      : Colors.white),
                              checkmarkColor: AppColor.white,
                              onSelected: (value) {
                                final newValue = List<int>.from(idValue);
                                if (value) {
                                  newValue.add(e.id ?? 0);
                                } else {
                                  newValue.remove(e.id ?? 0);
                                }
                                _selectedGenreId.value = newValue;

                                final genre = _listGenre.value
                                    .where((e) =>
                                        _selectedGenreId.value.contains(e.id))
                                    .map((e) => e.id)
                                    .toList();

                                context
                                    .read<DiscoverCubit>()
                                    .discover(withGenre: genre, page: 1);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
            const Gap(12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: AppText(
                text: 'Result',
                size: FontAppSize.font_14,
                color: AppColor.white,
                weight: FontAppWeight.medium,
              ),
            ),
            const Gap(12),
            BlocBuilder<DiscoverCubit, DiscoverState>(
              builder: (context, state) {
                if (state.status == DiscoverStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation(AppColor.red),
                    ),
                  );
                }
                if (state.status == DiscoverStatus.initial) {
                  return const Center(
                    child: AppText(
                      text: 'Choose genre to load data',
                      size: FontAppSize.font_18,
                      color: AppColor.white,
                      weight: FontAppWeight.medium,
                    ),
                  );
                }
                return Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent &&
                          state.status == DiscoverStatus.success) {
                        _onScroll(_selectedGenreId.value);
                      }
                      return false;
                    },
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
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
                                child: CircularProgressIndicator(
                                  color: AppColor.red,
                                ),
                              ),
                            );
                          }
                          ResultsModel movie = state.listData[index];
                          return MovieCard(
                            title: movie.originalTitle ?? '-',
                            date: movie.releaseDate ?? DateTime.now(),
                            vote: movie.voteAverage ?? 0.0,
                            poster: movie.posterPath ?? '-',
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
