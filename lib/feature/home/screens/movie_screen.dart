part of 'screens.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final ValueNotifier<List<Genres>> _listGenre = ValueNotifier([]);
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _loadGenres();
  }

  @override
  void dispose() {
    _listGenre.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  void _loadGenres() async {
    try {
      final response = await MovieServices().fetchGenres();
      _listGenre.value = response.data?.genres ?? [];
    } on DioException catch (e) {
      if (!mounted) return;
      AppDialog.showSnackbar(context, e.msgDioErr(), SnackBarStatus.failure);
    } finally {
      _isLoading.value = false;
    }
  }

  void _onScroll() {
    final state = context.read<NowPlayingCubit>().state;
    if (state.status == MovieStatusState.loadMore ||
        state.status == MovieStatusState.failure) return;

    final nextPage = (state.pagination.page ?? 0) + 1;
    context.read<NowPlayingCubit>().nowPlayingMovie(nextPage);

    print('SCROLLED $nextPage');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderTitle(
          label: 'Genres',
          onTap: () {},
        ),
        const Gap(12),
        ValueListenableBuilder(
          valueListenable: _isLoading,
          builder: (context, value, child) {
            if (value == true) {
              return child!;
            } else {
              return ValueListenableBuilder(
                valueListenable: _listGenre,
                builder: (context, value, child) => child!,
                child: SizedBox(
                  width: double.maxFinite,
                  height: 32,
                  child: ListView.separated(
                    itemCount: _listGenre.value.take(5).length,
                    separatorBuilder: (context, index) => const Gap(12),
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final genre = _listGenre.value[index];
                      return ActionChip(
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          print('${genre.id}');
                        },
                        label: AppText(
                            text: genre.name ?? '-',
                            size: FontAppSize.font_12,
                            color: AppColor.black),
                      );
                    },
                  ),
                ),
              );
            }
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
