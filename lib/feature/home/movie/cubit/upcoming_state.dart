part of 'upcoming_cubit.dart';

class UpcomingState extends Equatable {
  final PaginationResponseAPI<ResultsModel> pagination;
  final List<ResultsModel> listData;
  final MovieStatusState status;
  final String? err;
  final bool loadMore;
  const UpcomingState({
    this.pagination = const PaginationResponseAPI(),
    this.listData = const [],
    this.status = MovieStatusState.initial,
    this.err,
    this.loadMore = false,
  });

  UpcomingState copyWith({
    PaginationResponseAPI<ResultsModel>? pagination,
    List<ResultsModel>? listData,
    MovieStatusState? status,
    String? err,
    bool? loadMore,
  }) =>
      UpcomingState(
        pagination: pagination ?? this.pagination,
        listData: listData ?? this.listData,
        status: status ?? this.status,
        err: err,
        loadMore: loadMore ?? this.loadMore,
      );

  @override
  List<Object?> get props => [pagination, listData, status, err, loadMore];
}
