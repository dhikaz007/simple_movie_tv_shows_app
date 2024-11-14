import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final ProfileServices _profileServices = ProfileServices();

  void loadProfilte() async {
    try {
      emit(ProfileLoading());

      final response = await _profileServices.fetchProfile();
      emit(ProfileLoaded(profile: response.data ?? const AccountModel()));
    } catch (e) {
      emit(ProfileFailed(err: e.toString()));
    }
  }
}
