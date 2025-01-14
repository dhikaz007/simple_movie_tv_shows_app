import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'lists_state.dart';

class ListsCubit extends Cubit<ListsState> {
  ListsCubit() : super(const ListsState());

  final ListsServices _listsServices = ListsServices();

  void getLists({required int page}) async {
    final p = page;
    if (p > state.totalPage + 1) return;

    ListsStatus status = ListsStatus.initial;
    List<ListsModel> lists = List.of(state.listData);

    if (p == 1) {
      lists.clear();
    } else {
      status = ListsStatus.loadMore;
    }
    emit(state.copyWith(status: status));

    try {
      final response = await _listsServices.fetchLists(page);

      if (p > 1) {
        lists.addAll(response.results);
      } else {
        lists = response.results;
      }

      emit(state.copyWith(
        status: ListsStatus.success,
        listData: lists,
        page: page == response.page ? response.page : page,
        totalPage: response.totalPages,
      ));
    } catch (e) {
      emit(state.copyWith(status: ListsStatus.failure, err: e.toString()));
    }
  }
}
