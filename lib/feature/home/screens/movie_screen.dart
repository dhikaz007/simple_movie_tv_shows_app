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
      // final genres = await Isolate.run(() async {
      //   return response;
      // });
      final response = await MovieServices().fetchGenres();
      _listGenre.value = response.data?.genres ?? [];
    } on DioException catch (e) {
      if (!mounted) return;
      AppDialog.showSnackbar(context, e.msgDioErr(), SnackBarStatus.failure);
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderTitle(
          label: 'Genres',
          onTap: () async {
            Modular.to.pushNamed('/movie/discover');
          },
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
                child: Container(
                  constraints: const BoxConstraints.expand(
                    height: 32,
                  ),
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
        const Gap(12),
        Flexible(
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            //itemCount: 12,
            //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,

            //),
            // itemBuilder: (context, index) {
            //   return Container(
            //     alignment: Alignment.center,
            //     width: 120,
            //     height: 200,
            //     color: AppColor.grey2,
            //     child: AppText(
            //         text: 'Index ${index + 1}',
            //         size: FontAppSize.font_12,
            //         color: AppColor.black),
            //   );
            // },
            children: List.generate(10, (gen) {
              return Container(
                alignment: Alignment.center,
                width: 120,
                height: 120,
                color: AppColor.grey2,
                child: AppText(
                    text: 'Index ${gen + 1}',
                    size: FontAppSize.font_12,
                    color: AppColor.black),
              );
            }),
          ),
        ),
      ],
    );
  }
}
