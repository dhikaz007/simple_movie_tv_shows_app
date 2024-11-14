import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../constant/constant.dart';
import '../../../extensions/extensions.dart';
import '../../../shared/shared.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../cubit_movie/cubit/now_playing_cubit.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';
import 'widgets/widgets.dart';

part 'home_screen.dart';
part 'movie_screen.dart';
part 'tv_shows_screen.dart';
