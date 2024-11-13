import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'constant/constant.dart';
import 'feature/auth/cubit/auth_cubit.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');
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
    return BlocProvider(
      create: (context) => AuthCubit(),
      lazy: true,
      child: GlobalLoaderOverlay(
        overlayColor: AppColor.black.withAlpha(150).withOpacity(.3),
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
