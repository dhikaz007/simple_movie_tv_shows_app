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
  final int currentPage;

  const PopularLoaded({
    this.response = const [],
    this.lastPage = false,
    this.currentPage = 1,
  });

  PopularLoaded copyWith({
    List<ResultsModel>? response,
    bool? lastPage,
    int? currentPage,
  }) =>
      PopularLoaded(
        response: response ?? this.response,
        lastPage: lastPage ?? this.lastPage,
        currentPage: currentPage ?? this.currentPage,
      );
  @override
  List<Object?> get props => [response, lastPage, currentPage];
}

final class PopularFailed extends PopularState {
  final String err;

  const PopularFailed({required this.err});
  @override
  List<Object?> get props => [err];
}
