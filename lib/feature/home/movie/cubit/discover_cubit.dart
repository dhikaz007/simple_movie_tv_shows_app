import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../utils/utils.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit() : super(const DiscoverState());

  final MovieServices _movieServices = MovieServices();

  void discover({
    List<int?>? withGenre,
    int? page,
    bool? includeAdult = false,
    String? year,
  }) async {
    try {
      if (state.status == DiscoverStatus.loading ||
          state.status == DiscoverStatus.loadMore) return;

      if (page == 1) {
        emit(state.copyWith(status: DiscoverStatus.loading, loadMore: false));
      } else {
        emit(state.copyWith(status: DiscoverStatus.loadMore, loadMore: true));
      }

      final response = await _movieServices.fetchDiscover(
        withGenre: withGenre,
        page: page,
        includeAdult: includeAdult,
      );
      final searchList = page == 1
          ? response.results
          : [...state.listData, ...response.results];

      emit(state.copyWith(
        status: DiscoverStatus.success,
        listData: searchList,
        pagination: response,
        loadMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(err: e.toString(), status: DiscoverStatus.failure));
    }
  }

  void reset() {
    emit(const DiscoverState());
  }
}
