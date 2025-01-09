part of 'models.dart';

class AccountModel {
  final Avatar? avatar;
  final int? id;
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final bool? includeAdult;
  final String? username;

  const AccountModel({
    this.avatar,
    this.id,
    this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
      id: json['id'] != null ? json['id'] as int : null,
      iso6391: json['iso_639_1'] != null ? json['iso_639_1'] as String : null,
      iso31661:
          json['iso_3166_1'] != null ? json['iso_3166_1'] as String : null,
      name: json['name'] != null ? json['name'] as String : null,
      includeAdult:
          json['include_adult'] != null ? json['include_adult'] as bool : null,
      username: json['username'] != null ? json['username'] as String : null,
    );
  }

  @override
  String toString() {
    return 'AccountModel(avatar: $avatar, id: $id, iso6391: $iso6391, iso31661: $iso31661, name: $name, includeAdult: $includeAdult, username: $username)';
  }
}

class Avatar {
  final Gravatar? gravatar;
  final Tmdb? tmdb;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        gravatar: json['gravatar'] != null
            ? Gravatar.fromJson(json['gravatar'])
            : null,
        tmdb: json['tmdb'] != null ? Tmdb.fromJson(json['tmdb']) : null,
      );

  const Avatar({this.gravatar, this.tmdb});

  @override
  String toString() => 'Avatar(gravatar: $gravatar, tmdb: $tmdb)';
}

class Gravatar {
  final String? hash;

  const Gravatar({this.hash});

  factory Gravatar.fromJson(Map<String, dynamic> json) => Gravatar(
        hash: json["hash"] != null ? json['hash'] as String : null,
      );

  @override
  String toString() => 'Gravatar(hash: $hash)';
}

class Tmdb {
  final String? avatarPath;

  const Tmdb({this.avatarPath});

  factory Tmdb.fromJson(Map<String, dynamic> json) => Tmdb(
        avatarPath:
            json["avatar_path"] != null ? json["avatar_path"] as String : null,
      );

  @override
  String toString() => 'Tmdb(avatarPath: $avatarPath)';
}
