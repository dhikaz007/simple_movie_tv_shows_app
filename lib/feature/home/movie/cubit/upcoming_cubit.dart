import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../constant/constant.dart';
import '../../../../utils/utils.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(const UpcomingState());

  final MovieServices _movieServices = MovieServices();

  void upcoming(int? page) async {
    try {
      if (state.status == MovieStatusState.loading ||
          state.status == MovieStatusState.loadMore) return;

      if (page == 1) {
        emit(state.copyWith(status: MovieStatusState.loading, loadMore: false));
      } else {
        emit(state.copyWith(status: MovieStatusState.loadMore, loadMore: true));
      }
      final response = await _movieServices.fetchNowPlaying(page);
      List<ResultsModel> movieList = page == 1
          ? response.results as List<ResultsModel>
          : [...state.listData, ...response.results as List<ResultsModel>];
      emit(state.copyWith(
        status: MovieStatusState.success,
        listData: movieList,
        pagination: response,
        loadMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(err: e.toString(), status: MovieStatusState.failure));
    }
  }

  void reset() {
    emit(const UpcomingState());
  }
}
