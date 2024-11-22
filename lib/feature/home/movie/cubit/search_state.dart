part of 'search_cubit.dart';

enum SearchStatus { initial, loading, success, failure, loadMore }

class SearchState extends Equatable {
  final PaginationResponseAPI<ResultsModel> pagination;
  final List<ResultsModel> listData;
  final SearchStatus status;
  final String? err;
  final bool loadMore;
  const SearchState({
    this.pagination = const PaginationResponseAPI(),
    this.listData = const [],
    this.status = SearchStatus.initial,
    this.err,
    this.loadMore = false,
  });

  SearchState copyWith({
    PaginationResponseAPI<ResultsModel>? pagination,
    List<ResultsModel>? listData,
    SearchStatus? status,
    String? err,
    bool? loadMore,
  }) =>
      SearchState(
        pagination: pagination ?? this.pagination,
        listData: listData ?? this.listData,
        status: status ?? this.status,
        err: err,
        loadMore: loadMore ?? this.loadMore,
      );

  @override
  List<Object?> get props => [pagination, listData, status, err, loadMore];
}
