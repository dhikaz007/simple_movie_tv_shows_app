import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../constant/constant.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit() : super(const TopRatedState());

  final MovieServices _movieServices = MovieServices();

  void topRated(int page) async {
    final p = page;
    if (p > state.totalPage + 1) return;

    MovieStatusState status = MovieStatusState.initial;
    List<ResultsModel> topRated = List.of(state.listData);

    if (p == 1) {
      topRated.clear();
    } else {
      status = MovieStatusState.loadMore;
    }
    emit(state.copyWith(status: status));

    try {
      final response = await _movieServices.fetchTopRated(page);

      if (p > 1) {
        topRated.addAll(response.results);
      } else {
        topRated = response.results;
      }

      emit(state.copyWith(
        status: MovieStatusState.success,
        listData: topRated,
        page: response.page,
        totalPage: response.totalPages,
      ));
    } catch (e) {
      emit(state.copyWith(err: e.toString(), status: MovieStatusState.failure));
    }
  }

  void reset() {
    emit(const TopRatedState());
  }
}
