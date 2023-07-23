import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repository/tv_repository.dart';
import '../view_model/search_tv_view_model.dart';
import 'search_tv_page.dart';

class SearchTVMain extends StatelessWidget {
  const SearchTVMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchTVViewModel(
        tvRepository: TVRepositoryImpl(),
      ),
      child: const SearchTVPage(),
    );
  }
}
