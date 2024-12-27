part of 'top_rated_cubit.dart';

class TopRatedState extends Equatable {
  final List<ResultsModel> listData;
  final MovieStatusState status;
  final String? err;
  final int page;
  final int totalPage;
  const TopRatedState({
    this.listData = const [],
    this.status = MovieStatusState.initial,
    this.err,
    this.page = 1,
    this.totalPage = 1,
  });

  TopRatedState copyWith({
    List<ResultsModel>? listData,
    MovieStatusState? status,
    String? err,
    int? page,
    int? totalPage,
  }) =>
      TopRatedState(
        listData: listData ?? this.listData,
        status: status ?? this.status,
        err: err,
        page: page ?? this.page,
        totalPage: totalPage ?? this.totalPage,
      );

  @override
  List<Object?> get props => [listData, status, err, page, totalPage];
}
