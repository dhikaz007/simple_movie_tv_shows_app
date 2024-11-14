import 'package:flutter/material.dart';

part 'assets.dart';
part 'color.dart';
part 'url.dart';

enum MovieStatusState {
  initial,
  loading,
  loadMore,
  success,
  refreshSuccess,
  failure,
}
