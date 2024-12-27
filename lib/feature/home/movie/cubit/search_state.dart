part of 'search_cubit.dart';

enum SearchStatus { initial, loading, success, failure, loadMore }

class SearchState extends Equatable {
  final List<ResultsModel> listData;
  final SearchStatus status;
  final String? err;
  final int page;
  final int totalPage;
  const SearchState({
    this.listData = const [],
    this.status = SearchStatus.initial,
    this.err,
    this.page = 1,
    this.totalPage = 1,
  });

  SearchState copyWith({
    List<ResultsModel>? listData,
    SearchStatus? status,
    String? err,
    int? page,
    int? totalPage,
  }) =>
      SearchState(
        listData: listData ?? this.listData,
        status: status ?? this.status,
        err: err,
        page: page ?? this.page,
        totalPage: totalPage ?? this.totalPage,
      );

  @override
  List<Object?> get props => [
        listData,
        status,
        err,
        page,
        totalPage,
      ];
}
