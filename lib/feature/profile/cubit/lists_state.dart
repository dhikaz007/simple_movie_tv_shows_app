part of 'lists_cubit.dart';

enum ListsStatus { initial, loading, success, failure, loadMore }

class ListsState extends Equatable {
  final PaginationResponseAPI<ListsModel> listData;
  final ListsStatus status;
  final String? err;
  const ListsState({
    this.listData = const PaginationResponseAPI(),
    this.status = ListsStatus.initial,
    this.err,
  });

  ListsState copyWith({
    PaginationResponseAPI<ListsModel>? listData,
    ListsStatus? status,
    String? err,
  }) =>
      ListsState(
        listData: listData ?? this.listData,
        status: status ?? this.status,
        err: err,
      );

  @override
  List<Object?> get props => [listData, status, err];
}
