import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../utils/utils.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  final MovieServices _movieServices = MovieServices();

  //* Method 1
  void search({
    required String query,
    int? page,
    bool? includeAdult = false,
    String? year,
  }) async {
    final p = page ?? state.page;

    if (p > state.totalPage + 1) return;

    SearchStatus status = SearchStatus.initial;
    List<ResultsModel> search = List.of(state.listData);

    if (p == 1) {
      search.clear();
    } else {
      status = SearchStatus.loadMore;
    }
    emit(state.copyWith(status: status));

    try {
      final response = await _movieServices.fetchSearch(
        query: query,
        page: page,
        includeAdult: includeAdult,
        year: year,
      );

      if (p > 1) {
        search.addAll(response.results);
      } else {
        search = response.results;
      }

      emit(state.copyWith(
        status: SearchStatus.success,
        listData: search,
        totalPage: response.totalPages,
      ));
    } catch (e) {
      emit(state.copyWith(err: e.toString(), status: SearchStatus.failure));
    }
  }

  void reset() {
    emit(const SearchState());
  }
}
