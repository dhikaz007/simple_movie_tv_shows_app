part of 'popular_cubit.dart';

sealed class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object?> get props => [];
}

final class PopularInitial extends PopularState {}

final class PopularLoading extends PopularState {}

final class PopularLoaded extends PopularState {
  final List<ResultsModel> response;
  final bool lastPage;

  const PopularLoaded({required this.response, this.lastPage = false});

  PopularLoaded copyWith({
    List<ResultsModel>? response,
    bool? lastPage,
  }) =>
      PopularLoaded(
        response: response ?? this.response,
        lastPage: lastPage ?? this.lastPage,
      );
  @override
  List<Object?> get props => [response, lastPage];
}

final class PopularFailed extends PopularState {
  final String err;

  const PopularFailed({required this.err});
  @override
  List<Object?> get props => [err];
}

// class PopularState extends Equatable {
//   final PaginationResponseAPI<ResultsModel> pagination;
//   final List<ResultsModel> listData;
//   final MovieStatusState status;
//   final String? err;
//   final bool loadMore;
//   const PopularState({
//     this.pagination = const PaginationResponseAPI(),
//     this.listData = const [],
//     this.status = MovieStatusState.initial,
//     this.err,
//     this.loadMore = false,
//   });

//   PopularState copyWith({
//     PaginationResponseAPI<ResultsModel>? pagination,
//     List<ResultsModel>? listData,
//     MovieStatusState? status,
//     String? err,
//     bool? loadMore,
//   }) =>
//       PopularState(
//         pagination: pagination ?? this.pagination,
//         listData: listData ?? this.listData,
//         status: status ?? this.status,
//         err: err,
//         loadMore: loadMore ?? this.loadMore,
//       );

//   @override
//   List<Object?> get props => [pagination, listData, status, err, loadMore];
// }
