import 'package:flutter/material.dart';

import '../../../repositories/tv_repository.dart';
import '../../../models/search_tv_model.dart';

class SearchTVViewModel extends ChangeNotifier {
  final TVRepository tvRepository;

  SearchTVViewModel({required this.tvRepository});

  List<SearchTVResults>? _tvResult = [];
  SearchTVResults? _tvListResult;
  String _querySearch = '';

  List<SearchTVResults>? get tvResult => _tvResult;
  SearchTVResults? get tvListResult => _tvListResult;
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
