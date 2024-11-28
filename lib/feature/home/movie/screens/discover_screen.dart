part of 'screens.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
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

    final nextPage = (state.pagination.page ?? 0) + 1;
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
                    weight: FontAppWeight.medium,
                  ),
                ],
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
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: state.loadMore
                            ? state.listData.length + 1
                            : state.listData.length,
                        separatorBuilder: (context, index) => const Gap(8),
                        itemBuilder: (context, index) {
                          if (index >= state.listData.length) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.white,
                                ),
                              ),
                            );
                          }
                          ResultsModel movie = state.listData[index];
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
