import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../detail_page/view/detail_main.dart';
import '../view_model/search_movie_view_model.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/app_spacing.dart';
import '../../../utils/widget/app_scaffold.dart';
import 'widget/search_result_widget.dart';
import 'widget/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AppScaffold(
        isAppbar: AppBarVisibility.on,
        backgroundColor: AppColor.blacklist,
        title: 'Search',
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space20,
            vertical: AppSpacing.space8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<SearchMovieViewModel>(
                builder: (context, searchValue, _) {
                  return SearchWIdget(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    suffixIcon: InkWell(
                      onTap: () => searchController.text.isNotEmpty
                          ? searchController.clear()
                          : Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.clear,
                      ),
                    ),
                    onChanged: (value) {
                      searchValue.showSearchMovie(query: value);
                    },
                    onSubmitted: (value) {
                      value = searchController.text;
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.space20),
              Text(
                'Search Results',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColor.goldenBuddhaBelly,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppSpacing.space20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.4,
                child: Consumer<SearchMovieViewModel>(
                  builder: (context, searchValue, _) {
                    if (searchValue.querySearch.isEmpty) {
                      return Center(
                        child: Text(
                          'Result not found',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColor.goldenBuddhaBelly,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: searchValue.movieResult?.length,
                        itemBuilder: (context, index) {
                          return SearchResultWidget(
                            moviePoster:
                                searchValue.movieResult?[index].posterPath ??
                                    '',
                            movieTitle:
                                searchValue.movieResult?[index].title ?? '',
                            movieRating:
                                searchValue.movieResult?[index].voteAverage ??
                                    0.0,
                            movieOverview:
                                searchValue.movieResult?[index].overview ?? '',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailMain(
                                      movieBackdrop: searchValue
                                              .movieResult?[index]
                                              .backdropPath ??
                                          '',
                                      movieTitle: searchValue
                                              .movieResult?[index].title ??
                                          '',
                                      movieRating: searchValue
                                              .movieResult?[index]
                                              .voteAverage ??
                                          0.0,
                                      movieReleaseData: DateTime.parse(
                                          searchValue.movieResult?[index]
                                                  .releaseDate ??
                                              ''),
                                      movieOverview: searchValue
                                              .movieResult?[index].overview ??
                                          '',
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
