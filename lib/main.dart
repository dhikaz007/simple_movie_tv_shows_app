import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'constant/constant.dart';
import 'feature/auth/cubit/auth_cubit.dart';
import 'feature/home/movie/cubit/now_playing_cubit.dart';
import 'feature/home/movie/cubit/popular_cubit.dart';
import 'feature/home/movie/cubit/top_rated_cubit.dart';
import 'feature/home/movie/cubit/upcoming_cubit.dart';
import 'feature/profile/cubit/profile_cubit.dart';
import 'hive_storage/profile_hive.dart';
import 'routes/routes.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileHiveAdapter());
  await Hive.openBox<ProfileHive>('PROFILE');
  await FkUserAgent.init();
  await initializeDateFormatting('id');

  final region = WidgetsBinding.instance.platformDispatcher.locale.countryCode;
  await LocalStorage.setRegion(region: region ?? 'EN');
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
    (_) => runApp(
      ModularApp(
        module: AppRoutes(),
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => NowPlayingCubit()),
        BlocProvider(create: (context) => PopularCubit()),
        BlocProvider(create: (context) => TopRatedCubit()),
        BlocProvider(create: (context) => UpcomingCubit()),
      ],
      child: GlobalLoaderOverlay(
        overlayColor: AppColor.black.withAlpha(150).withOpacity(.3),
        transitionBuilder: (child, anim) => ScaleTransition(
          scale: anim,
          child: child,
        ),
        overlayWidgetBuilder: (progress) => Center(
          child: Container(
            color: AppColor.white,
            padding: const EdgeInsets.all(12),
            child: const CircularProgressIndicator.adaptive(),
          ),
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            fontFamily: 'Montserrat',
          ),
          routerConfig: Modular.routerConfig,
        ),
      ),
    );
  }
}
