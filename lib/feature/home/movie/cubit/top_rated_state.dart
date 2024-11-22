part of 'top_rated_cubit.dart';

class TopRatedState extends Equatable {
  final PaginationResponseAPI<ResultsModel> pagination;
  final List<ResultsModel> listData;
  final MovieStatusState status;
  final String? err;
  final bool loadMore;
  const TopRatedState({
    this.pagination = const PaginationResponseAPI(),
    this.listData = const [],
    this.status = MovieStatusState.initial,
    this.err,
    this.loadMore = false,
  });

  TopRatedState copyWith({
    PaginationResponseAPI<ResultsModel>? pagination,
    List<ResultsModel>? listData,
    MovieStatusState? status,
    String? err,
    bool? loadMore,
  }) =>
      TopRatedState(
        pagination: pagination ?? this.pagination,
        listData: listData ?? this.listData,
        status: status ?? this.status,
        err: err,
        loadMore: loadMore ?? this.loadMore,
      );

  @override
  List<Object?> get props => [pagination, listData, status, err, loadMore];
}
