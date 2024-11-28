import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:gap/gap.dart';

import '../../../../constant/constant.dart';
import '../../../../extensions/extensions.dart';
import '../../../../shared/shared.dart';
import '../cubit/discover_cubit.dart';
import '../cubit/now_playing_cubit.dart';
import '../cubit/search_cubit.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';
import 'widgets/widgets.dart';

part 'discover_screen.dart';
part 'movie_detail_screen.dart';
part 'search_movie_screen.dart';