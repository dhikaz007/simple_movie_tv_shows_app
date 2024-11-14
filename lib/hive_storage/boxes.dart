import 'package:hive/hive.dart';

import 'profile_hive.dart';

class Boxes {
  static Box<ProfileHive> getProfile() =>
      Hive.box<ProfileHive>("PROFILE");

  static ProfileHive getProfileValue() => getProfile().values.first;

  static void deleteProfile() {
    var hasBox = getProfile().isNotEmpty;
    if (hasBox) {
      getProfile().clear();
    }
  }
}