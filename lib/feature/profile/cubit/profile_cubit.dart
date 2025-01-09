import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../hive_storage/boxes.dart';
import '../../../hive_storage/profile_hive.dart';
import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final ProfileServices _profileServices = ProfileServices();

  void loadProfile() async {
    try {
      emit(ProfileLoading());

      final response = await _profileServices.fetchProfile();

      var box = Boxes.getProfile();
      print('BOX ${box.values}');

      if (box.values.isEmpty) {
        var profile = ProfileHive()
          ..gravatar = response.data!.avatar!.gravatar!.hash!
          ..avatarPath = response.data!.avatar!.tmdb!.avatarPath!
          ..id = response.data!.id!
          ..iso6391 = response.data!.iso6391!
          ..iso31661 = response.data!.iso31661!
          ..name = response.data!.name!
          ..includeAdult = response.data!.includeAdult!
          ..username = response.data!.username!;
        await box.add(profile);
      } else {
        var profileStorage = box.values.first;
        profileStorage.gravatar = response.data!.avatar!.gravatar!.hash!;
        profileStorage.avatarPath = response.data!.avatar!.tmdb!.avatarPath!;
        profileStorage.id = response.data!.id!;
        profileStorage.iso6391 = response.data!.iso6391!;
        profileStorage.iso31661 = response.data!.iso31661!;
        profileStorage.name = response.data!.name!;
        profileStorage.includeAdult = response.data!.includeAdult!;
        profileStorage.username = response.data!.username!;
        profileStorage.save();
      }

      emit(ProfileLoaded(profile: response.data ?? const AccountModel()));
    } catch (e) {
      emit(ProfileFailed(err: e.toString()));
    }
  }
}
