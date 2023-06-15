import 'package:flutter/material.dart';

import '../../../data/repository/tv_repository.dart';
import '../../../data/model/search_tv_model.dart';

class SearchTVViewModel extends ChangeNotifier {
  final TVRepository tvRepository;

  SearchTVViewModel({required this.tvRepository});

  List<SearchTVResult>? _tvResult = [];
  String _querySearch = '';

  List<SearchTVResult>? get tvResult => _tvResult;
  String get querySearch => _querySearch;

  Future<void> showSearchTV({required String query}) async {
    _tvResult = await tvRepository.loadSearchTV(query: query);
    _querySearch = _tvResult
            ?.where(
              (element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList()
            .toString() ??
        '';
  }
}
