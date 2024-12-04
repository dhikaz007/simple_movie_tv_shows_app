import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../constant/constant.dart';
import '../../../../utils/utils.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit() : super(PopularInitial());

  final MovieServices _movieServices = MovieServices();

  void popular(int? page) async {
    try {
      if (state is PopularLoaded && (state as PopularLoaded).lastPage) return;

      if (state is PopularInitial) {
        emit(PopularLoading());
      }

      page = (state is PopularLoaded)
          ? ((state as PopularLoaded).response.length ~/ 20) + 1
          : 1;
      final popular = await _movieServices.fetchPopular(page);

      if (popular.results == null) {
        emit((state as PopularLoaded).copyWith(lastPage: true));
      } else {
        emit(PopularLoaded(
            response: (state is PopularLoaded)
                ? (state as PopularLoaded).response + (popular.results ?? [])
                : popular.results ?? []));
      }
    } catch (e) {
      emit(PopularFailed(err: e.toString()));
    }
  }

  // void popular(int? page) async {
  //   try {
  //     if (state.status == MovieStatusState.loading ||
  //         state.status == MovieStatusState.loadMore) return;

  //     if (page == 1) {
  //       emit(state.copyWith(status: MovieStatusState.loading, loadMore: false));
  //     } else {
  //       emit(state.copyWith(status: MovieStatusState.loadMore, loadMore: true));
  //     }
  //     final response = await _movieServices.fetchNowPlaying(page);
  //     List<ResultsModel> movieList = page == 1
  //         ? response.results as List<ResultsModel>
  //         : [...state.listData, ...response.results as List<ResultsModel>];
  //     emit(state.copyWith(
  //       status: MovieStatusState.success,
  //       listData: movieList,
  //       pagination: response,
  //       loadMore: false,
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(err: e.toString(), status: MovieStatusState.failure));
  //   }
  // }

  // void reset() {
  //   emit(const PopularState());
  // }
}
