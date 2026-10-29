import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/login_params.dart';
import '../../domain/entities/register_params.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/register_use_case.dart';
import 'auth_state.dart';

final class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase login,
    required RegisterUseCase register,
    required LogoutUseCase logout,
    required GetCurrentUserUseCase getCurrentUser,
    required TokenStorage tokenStorage,
  }) : _login = login,
       _register = register,
       _logout = logout,
       _getCurrentUser = getCurrentUser,
       _tokenStorage = tokenStorage,
       super(const AuthState());

  final LoginUseCase _login;
  final RegisterUseCase _register;
  final LogoutUseCase _logout;
  final GetCurrentUserUseCase _getCurrentUser;
  final TokenStorage _tokenStorage;

  Future<void> restoreSession() async {
    final token = await _tokenStorage.read();
    if (token == null || token.isEmpty) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
      return;
    }
    final result = await _getCurrentUser();
    if (isClosed) return;
    switch (result) {
      case Success<UserEntity>(:final data):
        emit(AuthState(status: AuthStatus.authenticated, user: data));
      case Failed<UserEntity>(failure: UnauthorizedFailure()):
        await _tokenStorage.clear();
        emit(const AuthState(status: AuthStatus.unauthenticated));
      case Failed<UserEntity>(:final failure):
        if (failure is NetworkFailure || failure is TimeoutFailure) {
          emit(const AuthState());
        } else {
          emit(AuthState(status: AuthStatus.failure, failure: failure));
        }
    }
  }

  Future<void> login(LoginParams params) async {
    emit(const AuthState(status: AuthStatus.authenticating));
    await _authenticate(() => _login(params));
  }

  Future<void> register(RegisterParams params) async {
    emit(const AuthState(status: AuthStatus.authenticating));
    await _authenticate(() => _register(params));
  }

  Future<void> logout() async {
    await _logout();
    if (!isClosed) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  void handleUnauthorized() {
    if (!isClosed) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  void clearFailure() {
    if (state.status == AuthStatus.failure) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> _authenticate(
    Future<Result<AuthSession>> Function() request,
  ) async {
    final result = await request();
    if (isClosed) return;
    switch (result) {
      case Success<AuthSession>(:final data):
        emit(AuthState(status: AuthStatus.authenticated, user: data.user));
      case Failed<AuthSession>(:final failure):
        emit(AuthState(status: AuthStatus.failure, failure: failure));
    }
  }
}
