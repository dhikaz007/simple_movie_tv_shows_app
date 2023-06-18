import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/tv_repository.dart';
import '../view_model/view_model.dart';
import 'tv_home_page.dart';

class TVHomeMain extends StatelessWidget {
  const TVHomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TopRatedTVViewModel(
            tvRepository: TVRepositoryImpl(),
          )..showTopRatedTV(context),
        ),
        ChangeNotifierProvider(
          create: (context) => OnTheAirTVViewModel(
            tvRepository: TVRepositoryImpl(),
          )..showOnTheAirTV(context),
        ),
        ChangeNotifierProvider(
          create: (context) => AiringTodayTVViewModel(
            tvRepository: TVRepositoryImpl(),
          )..showNowPlayingTV(context),
        ),
        ChangeNotifierProvider(
          create: (context) => PopularTVViewModel(
            tvRepository: TVRepositoryImpl(),
          )..showPopularTV(context),
        ),
      ],
      child: const TVHomePage(),
    );
  }
}
