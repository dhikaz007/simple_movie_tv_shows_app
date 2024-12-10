part of 'screens.dart';

class MovieDetailScreen extends StatelessWidget {
  final ResultsModel movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: DefaultBackground(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: MediaQuery.sizeOf(context).height / 4,
              pinned: true,
              floating: true,
              leading: BackButton(
                onPressed: () {
                  Modular.to.pop();
                },
                color: AppColor.red,
              ),
              title: AppText(
                text: movie.originalTitle ?? '-',
                size: FontAppSize.font_20,
                color: AppColor.red,
                weight: FontAppWeight.bold,
              ),
              centerTitle: true,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: CachedImage(
                  imageUrl:
                      '${UrlConstant.baseUrlImageOriginal}${movie.backdropPath}',
                ),
              ),
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: const [
              AppText(
                text: 'CHILD !',
                size: FontAppSize.font_14,
                color: AppColor.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
