// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileHiveAdapter extends TypeAdapter<ProfileHive> {
  @override
  final int typeId = 1;

  @override
  ProfileHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileHive()
      ..gravatar = fields[0] as String
      ..avatarPath = fields[1] as String
      ..id = fields[2] as int
      ..iso6391 = fields[3] as String
      ..iso31661 = fields[4] as String
      ..name = fields[5] as String
      ..includeAdult = fields[6] as bool
      ..username = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, ProfileHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.gravatar)
      ..writeByte(1)
      ..write(obj.avatarPath)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.iso6391)
      ..writeByte(4)
      ..write(obj.iso31661)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.includeAdult)
      ..writeByte(7)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
