import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../home/movie/domain/models/models.dart';
import '../domain/services/services.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(const WatchlistState());

  final WatchlistServices _watchlistServices = WatchlistServices();

  void myWatchlist({required int page, required String order}) async {
    final p = page;
    if (p > state.totalPage + 1) return;

    WatchListStatus status = WatchListStatus.initial;
    List<ResultsModel> watchlist = List.of(state.listData);

    if (p == 1) {
      watchlist.clear();
    } else {
      status = WatchListStatus.loadMore;
    }
    emit(state.copyWith(status: status));

    try {
      final response =
          await _watchlistServices.fetchWatchList(page: page, order: order);

      if (p > 1) {
        watchlist.addAll(response.results);
      } else {
        watchlist = response.results;
      }

      emit(state.copyWith(
        status: WatchListStatus.success,
        listData: watchlist,
        page: page == response.page ? response.page : page,
        totalPage: response.totalPages,
      ));
    } catch (e) {
      emit(state.copyWith(err: e.toString(), status: WatchListStatus.failure));
    }
  }
}
