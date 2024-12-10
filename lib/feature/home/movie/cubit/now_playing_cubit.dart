import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../constant/constant.dart';
import '../../../../utils/utils.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit() : super(const NowPlayingState());

  final MovieServices _movieServices = MovieServices();

  //* Method 2
  void nowPlaying(int? page) async {
    // Cek jika sedang dalam status loading atau load more
    if (state.status == MovieStatusState.loading ||
        state.status == MovieStatusState.loadMore) return;

    try {
      // Atur status loading atau loadMore berdasarkan halaman
      emit(state.copyWith(
        status:
            page == 1 ? MovieStatusState.loading : MovieStatusState.loadMore,
        loadMore: page != 1,
      ));

      // Fetch data dari API
      final response = await _movieServices.fetchNowPlaying(page);

      // Cek jika ini adalah halaman terakhir
      if (response.page == response.totalPages) {
        emit(state.copyWith(loadMore: false));
        return;
      }

      // Perbarui daftar film berdasarkan halaman
      final List<ResultsModel> movieList = page == 1
          ? response.results
          : [...state.listData, ...response.results];

      // Emit state dengan data yang diperbarui
      emit(state.copyWith(
        status: MovieStatusState.success,
        listData: movieList,
        pagination: response,
        loadMore: false,
      ));
    } catch (e) {
      // Tangani error dan emit status failure
      emit(state.copyWith(
        err: e.toString(),
        status: MovieStatusState.failure,
      ));
    }
  }

  void reset() {
    emit(const NowPlayingState());
  }
}
