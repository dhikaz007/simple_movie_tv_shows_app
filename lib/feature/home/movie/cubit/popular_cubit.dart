import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
          ? (state as PopularLoaded).currentPage + 1
          : 1;
      final popular = await _movieServices.fetchPopular(page);

      if (popular.results.isEmpty) {
        emit((state as PopularLoaded).copyWith(lastPage: true));
      } else {
        emit(PopularLoaded(
          response: (state is PopularLoaded)
              ? (state as PopularLoaded).response + popular.results
              : popular.results,
          currentPage: page,
          lastPage: popular.results.length < 20,
        ));
      }
    } catch (e) {
      emit(PopularFailed(err: e.toString()));
    }
  }

  void reset() {
    emit(PopularInitial());
  }
}
