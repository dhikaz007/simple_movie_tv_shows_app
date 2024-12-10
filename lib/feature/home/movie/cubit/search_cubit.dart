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
    try {
      if (state.status == SearchStatus.loading ||
          state.status == SearchStatus.loadMore) return;

      if (page == 1) {
        emit(state.copyWith(status: SearchStatus.loading, loadMore: false));
      } else {
        emit(state.copyWith(status: SearchStatus.loadMore, loadMore: true));
      }

      final response = await _movieServices.fetchSearch(
        query: query,
        page: page,
        includeAdult: includeAdult,
        year: year,
      );

      if (response.page == response.totalPages) {
        emit(state.copyWith(loadMore: false)); // Set loadMore ke false
        return; // Keluar dari fungsi
      }

      final searchList = page == 1
          ? response.results
          : [...state.listData, ...response.results];

      emit(state.copyWith(
        status: SearchStatus.success,
        listData: searchList,
        pagination: response,
        loadMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(err: e.toString(), status: SearchStatus.failure));
    }
  }

  void reset() {
    emit(const SearchState());
  }
}
