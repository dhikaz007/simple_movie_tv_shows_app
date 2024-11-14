part of 'now_playing_cubit.dart';

class NowPlayingState extends Equatable {
  final PaginationResponseAPI<ResultsModel> pagination;
  final List<ResultsModel> listData;
  final MovieStatusState status;
  final String? err;
  final bool loadMore;
  const NowPlayingState({
    this.pagination = const PaginationResponseAPI(),
    this.listData = const [],
    this.status = MovieStatusState.initial,
    this.err,
    this.loadMore = false,
  });

  NowPlayingState copyWith({
    PaginationResponseAPI<ResultsModel>? pagination,
    List<ResultsModel>? listData,
    MovieStatusState? status,
    String? err,
    bool? loadMore,
  }) =>
      NowPlayingState(
        pagination: pagination ?? this.pagination,
        listData: listData ?? this.listData,
        status: status ?? this.status,
        err: err,
        loadMore: loadMore ?? this.loadMore,
      );

  @override
  List<Object?> get props => [pagination, listData, status, err, loadMore];
}
