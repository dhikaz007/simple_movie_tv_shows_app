part of 'watchlist_cubit.dart';

enum WatchListStatus { initial, laoding, success, failure, loadMore }

class WatchlistState extends Equatable {
  final List<ResultsModel> listData;
  final WatchListStatus status;
  final int page;
  final int totalPage;
  final String? err;
  const WatchlistState({
    this.listData = const [],
    this.status = WatchListStatus.initial,
    this.page = 1,
    this.totalPage = 1,
    this.err,
  });

  WatchlistState copyWith({
    List<ResultsModel>? listData,
    WatchListStatus? status,
    int? page,
    int? totalPage,
    String? err,
  }) =>
      WatchlistState(
        listData: listData ?? this.listData,
        status: status ?? this.status,
        page: page ?? this.page,
        totalPage: totalPage ?? this.totalPage,
        err: err,
      );

  @override
  List<Object?> get props => [listData, status, page, totalPage, err];
}
