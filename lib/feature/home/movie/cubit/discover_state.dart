part of 'discover_cubit.dart';

enum DiscoverStatus { initial, loading, success, failure, loadMore }

class DiscoverState extends Equatable {
  final PaginationResponseAPI<ResultsModel> pagination;
  final List<ResultsModel> listData;
  final DiscoverStatus status;
  final String? err;
  final bool loadMore;
  const DiscoverState({
    this.pagination = const PaginationResponseAPI(),
    this.listData = const [],
    this.status = DiscoverStatus.initial,
    this.err,
    this.loadMore = false,
  });

  DiscoverState copyWith({
    PaginationResponseAPI<ResultsModel>? pagination,
    List<ResultsModel>? listData,
    DiscoverStatus? status,
    String? err,
    bool? loadMore,
  }) =>
      DiscoverState(
        pagination: pagination ?? this.pagination,
        listData: listData ?? this.listData,
        status: status ?? this.status,
        err: err,
        loadMore: loadMore ?? this.loadMore,
      );

  @override
  List<Object?> get props => [pagination, listData, status, err, loadMore];
}
