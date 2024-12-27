part of 'search_cubit.dart';

enum SearchStatus { initial, loading, success, failure, loadMore }

class SearchState extends Equatable {
  final PaginationResponseAPI<ResultsModel> pagination;
  final List<ResultsModel> listData;
  final SearchStatus status;
  final String? err;
  final int page;
  final int totalPage;
  const SearchState({
    this.pagination = const PaginationResponseAPI(),
    this.listData = const [],
    this.status = SearchStatus.initial,
    this.err,
    this.page = 1,
    this.totalPage = 1,
  });

  SearchState copyWith({
    PaginationResponseAPI<ResultsModel>? pagination,
    List<ResultsModel>? listData,
    SearchStatus? status,
    String? err,
    int? page,
    int? totalPage,
  }) =>
      SearchState(
        pagination: pagination ?? this.pagination,
        listData: listData ?? this.listData,
        status: status ?? this.status,
        err: err,
        page: page ?? this.page,
        totalPage: totalPage ?? this.totalPage,
      );

  @override
  List<Object?> get props => [
        pagination,
        listData,
        status,
        err,
        page,
        totalPage,
      ];
}
