import 'package:hive/hive.dart';

part 'profile_hive.g.dart';

@HiveType(typeId: 1)
class ProfileHive extends HiveObject {
  @HiveField(0)
  late String gravatar;

  @HiveField(1)
  late String avatarPath;

  @HiveField(2)
  late int id;

  @HiveField(3)
  late String iso6391;

  @HiveField(4)
  late String iso31661;

  @HiveField(5)
  late String name;

  @HiveField(6)
  late bool includeAdult;

  @HiveField(7)
  late String username;

  @override
  String toString() {
    return 'ProfileHive(gravatar: $gravatar, avatarPath: $avatarPath, id: $id, iso6391: $iso6391, iso31661: $iso31661, name: $name, includeAdult: $includeAdult, username: $username)';
  }
}
