part of 'screens.dart';

class PopularMovieScreen extends StatefulWidget {
  const PopularMovieScreen({super.key});

  @override
  State<PopularMovieScreen> createState() => _PopularMovieScreenState();
}

class _PopularMovieScreenState extends State<PopularMovieScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showFab = ValueNotifier<bool>(false);
  final PagingController<int, ResultsModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<PopularCubit>().popular(pageKey);
    });
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
    _pagingController.dispose();
    _scrollController.dispose();
    _showFab.dispose();
    super.dispose();
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
                    text: 'Popular Movie',
                    size: FontAppSize.font_18,
                    color: AppColor.white,
                    weight: FontAppWeight.medium,
                  ),
                ),
              ),
            ),
            const Gap(12),
            BlocListener<PopularCubit, PopularState>(
              listener: (context, state) {
                if (state is PopularLoaded) {
                  _pagingController.appendPage(state.response,
                      state.lastPage ? null : state.response.length ~/ 20 + 1);
                } else if (state is PopularFailed) {
                  _pagingController.error = state.err;
                  AppDialog.showSnackbar(
                      context, _pagingController.error, SnackBarStatus.failure);
                }
              },
              child: Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: PagedGridView<int, ResultsModel>(
                    pagingController: _pagingController,
                    physics: const ClampingScrollPhysics(),
                    scrollController: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .7,
                    ),
                    builderDelegate: PagedChildBuilderDelegate(
                      animateTransitions: true,
                      newPageProgressIndicatorBuilder: (context) =>
                          const Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation(AppColor.red),
                        ),
                      ),
                      firstPageProgressIndicatorBuilder: (context) =>
                          const Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation(AppColor.red),
                        ),
                      ),
                      itemBuilder: (context, item, index) {
                        return MovieCard(
                          title: item.originalTitle ?? '-',
                          date: item.releaseDate ?? DateTime.now(),
                          vote: item.voteAverage ?? 0.0,
                          poster: item.posterPath ?? '-',
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
