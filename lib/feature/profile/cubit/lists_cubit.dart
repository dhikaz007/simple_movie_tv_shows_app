import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'lists_state.dart';

class ListsCubit extends Cubit<ListsState> {
  ListsCubit() : super(const ListsState());

  final ListsServices _listsServices = ListsServices();

  void getLists({required int page}) async {
    final p = page;
    try {
      emit(state.copyWith(status: ListsStatus.loading));
      final response = await _listsServices.fetchLists(p);

      emit(state.copyWith(
        status: ListsStatus.success,
        listData: response,
      ));
    } catch (e) {
      emit(state.copyWith(status: ListsStatus.failure, err: e.toString()));
    }
  }
}
