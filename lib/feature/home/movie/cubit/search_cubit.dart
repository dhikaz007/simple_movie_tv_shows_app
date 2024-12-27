import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  final MovieServices _movieServices = MovieServices();

  //* Method 1
  void search({
    required String query,
    required int page,
    bool? includeAdult = false,
    String? year,
  }) async {
    final p = page;

    if (p > state.totalPage + 1) return;

    bool isLoadMore = p > 1;
    emit(state.copyWith(
        status: isLoadMore ? SearchStatus.loadMore : SearchStatus.loading));

    List<ResultsModel> search = List.of(state.listData);

    if (p == 1) {
      search.clear();
    }

    try {
      final response = await _movieServices.fetchSearch(
        query: query,
        page: page,
        includeAdult: includeAdult,
        year: year,
      );

      if (isLoadMore) {
        search.addAll(response.results);
      } else {
        search = response.results;
        // search = response.results;
      }

      emit(state.copyWith(
        status: SearchStatus.success,
        listData: search,
        totalPage: response.totalPages,
        page: response.page,
      ));
    } catch (e) {
      emit(state.copyWith(err: e.toString(), status: SearchStatus.failure));
    }
  }

  void reset() {
    emit(const SearchState());
  }
}
