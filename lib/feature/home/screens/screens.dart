import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../constant/constant.dart';
import '../../../extensions/extensions.dart';
import '../../../shared/shared.dart';
import '../../../utils/utils.dart';
import '../movie/cubit/popular_cubit.dart';
import '../movie/domain/models/models.dart';
import '../movie/domain/services/services.dart';
import 'widgets/widgets.dart';

part 'home_screen.dart';
part 'movie_screen.dart';
part 'tv_shows_screen.dart';
