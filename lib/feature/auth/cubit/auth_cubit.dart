import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../hive_storage/boxes.dart';
import '../../../hive_storage/hive_storage.dart';
import '../../../utils/utils.dart';
import '../../profile/domain/services/services.dart';

import '../domain/services/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthUnauthenticated());

  final AuthServices _authServices = AuthServices();
  final ProfileServices _profileServices = ProfileServices();

  void login({required String username, required String password}) async {
    try {
      emit(AuthLoading());

      await _authServices.fetchToken();
      await _authServices.fetchLogin(username: username, password: password);

      final id = await _authServices.fetchSession();
      await LocalStorage.setSessionId(id: id.data?.sessionId ?? '-');
      
      final response = await _profileServices.fetchProfile();
      var profile = ProfileHive()
        ..gravatar = (response.data?.avatar?.gravatar?.hash ?? '-')
        ..avatarPath = (response.data?.avatar?.tmdb?.avatarPath ?? '-')
        ..id = (response.data?.id ?? 0)
        ..iso6391 = (response.data?.iso6391 ?? '-')
        ..iso31661 = (response.data?.iso31661 ?? '-')
        ..name = (response.data?.name ?? '-')
        ..includeAdult = (response.data?.includeAdult ?? false)
        ..username = (response.data?.username ?? '-');

      final box = Boxes.getProfile();
      Boxes.deleteProfile();
      await box.add(profile);
      
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(err: e.toString()));
    }
  }

  void logout() async {
    try {
      emit(AuthLoading());
      final response = await _authServices.fetchLogout();
      if (response.data != true) {
        emit(const AuthError(err: 'ERROR LOGOUT'));
      } else {
        await LocalStorage.removeToken();
        Boxes.deleteProfile();
        emit(AuthLogOut());
      }
    } catch (e) {
      emit(AuthError(err: e.toString()));
    }
  }
}
