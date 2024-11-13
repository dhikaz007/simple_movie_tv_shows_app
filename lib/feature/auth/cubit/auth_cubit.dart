import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../domain/services/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthUnauthenticated());

  final AuthServices _authServices = AuthServices();

  void login({required String username, required String password}) async {
    try {
      emit(AuthLoading());

      await _authServices.fetchToken();
      final response = await _authServices.fetchLogin(
          username: username, password: password);
      if (response.data?.success != true) {
        emit(const AuthError(err: 'ERROR LOGIN'));
      } else {
        final id = await _authServices.fetchSession();
        await LocalStorage.setSessionId(id: id.data?.sessionId ?? '-');
        emit(AuthAuthenticated());
      }
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
        emit(AuthLogOut());
      }
    } catch (e) {
      emit(AuthError(err: e.toString()));
    }
  }
}
