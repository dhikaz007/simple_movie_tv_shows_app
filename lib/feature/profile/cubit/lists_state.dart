part of 'lists_cubit.dart';

enum ListsStatus { initial, loading, success, failure, loadMore }

class ListsState extends Equatable {
  final List<ListsModel> listData;
  final ListsStatus status;
  final int page;
  final int totalPage;
  final String? err;
  const ListsState({
    this.listData = const [],
    this.status = ListsStatus.initial,
    this.page = 1,
    this.totalPage = 1,
    this.err,
  });

  ListsState copyWith({
    List<ListsModel>? listData,
    ListsStatus? status,
    int? page,
    int? totalPage,
    String? err,
  }) =>
      ListsState(
        listData: listData ?? this.listData,
        status: status ?? this.status,
        page: page ?? this.page,
        totalPage: totalPage ?? this.totalPage,
        err: err,
      );

  @override
  List<Object?> get props => [listData, status, page, totalPage, err];
}
