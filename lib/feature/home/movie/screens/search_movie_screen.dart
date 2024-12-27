part of 'screens.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({super.key});

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().reset();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll(TextEditingController query) async {
    final state = context.read<SearchCubit>().state;
    if (state.status == SearchStatus.loadMore ||
        state.status == SearchStatus.failure) return;

    final nextPage = state.page + 1;
    context.read<SearchCubit>().search(query: query.text, page: nextPage);

    print('SCROLLED $nextPage');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: DefaultBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                      const Flexible(
                        child: Center(
                          child: AppText(
                            text: 'Search Movie',
                            size: FontAppSize.font_18,
                            color: AppColor.white,
                            weight: FontAppWeight.medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  TextField(
                    controller: _searchController,
                    style: const TextStyle(fontSize: 12, color: AppColor.white),
                    decoration: InputDecoration(
                      hintText: 'Search....',
                      hintStyle:
                          const TextStyle(fontSize: 12, color: AppColor.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColor.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColor.red,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      suffixIcon: ValueListenableBuilder(
                        valueListenable: _searchController,
                        builder: (context, value, child) {
                          if (value.text.isNotEmpty) {
                            return child!;
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                        child: InkWell(
                          onTap: () {
                            _searchController.clear();
                            FocusScope.of(context).unfocus();
                            context.read<SearchCubit>().reset();
                          },
                          child: const Icon(
                            Icons.close,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                      prefixIcon: ValueListenableBuilder(
                        valueListenable: _searchController,
                        builder: (context, value, child) {
                          if (value.text.isEmpty) {
                            return child!;
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                        child: const Icon(
                          Icons.search,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                    onSubmitted: (value) {
                      print(value.toLowerCase());
                      context
                          .read<SearchCubit>()
                          .search(query: value.toLowerCase(), page: 1);
                    },
                  ),
                  const Gap(20),
                  const AppText(
                    text: 'Result',
                    size: FontAppSize.font_14,
                    color: AppColor.red,
                    weight: FontAppWeight.medium,
                  ),
                  const Gap(20),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      print(state.status);
                      if (state.status == SearchStatus.initial) {
                        return const Center(
                          child: AppText(
                            text: 'No data',
                            size: FontAppSize.font_16,
                            color: AppColor.white,
                            weight: FontAppWeight.medium,
                          ),
                        );
                      }

                      int items = state.listData.length;
                      if (state.page < state.totalPage) {
                        items += 1;
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent) {
                            _onScroll(_searchController);
                          }
                          return false;
                        },
                        child: Expanded(
                          child: ListView.separated(
                            itemCount: items,
                            separatorBuilder: (context, index) => const Column(
                              children: [
                                Gap(4),
                                Divider(color: AppColor.white),
                                Gap(4),
                              ],
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
                              ResultsModel searchMovie = state.listData[index];
                              return InkWell(
                                onTap: () {
                                  Modular.to.pushNamed('/movie/detail',
                                      arguments: searchMovie);
                                },
                                child: SearchCardWidget(movie: searchMovie),
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
          ),
        ),
      ),
    );
  }
}
