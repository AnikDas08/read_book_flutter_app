import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/authentication/data/auth_repository.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/authentication/riverpod/auth_state.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.read(authRepositoryProvider);
    return const AuthState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.login(email, password);
    if (response.isSuccess) {
      print("Successfull Login");
      state = state.copyWith(isLoading: false, isAuthenticated: true);
      appRouter.replaceAll([
        NavigationRoute(
          children: [const HomeRoute()],
        ),
      ]);
    }
    else{
      state = state.copyWith(isLoading: false, isAuthenticated: true);
    }
  }

  loginAsGuest() async {
    state = state.copyWith(isLoading: false, isAuthenticated: true);
    appRouter.replaceAll([
      NavigationRoute(
        children: [const HomeRoute()],
      ),
    ]);
  }

  Future<void> signup(String name, String email, String password, int age) async {
    state = state.copyWith(isLoading: true, error: null);
    final response = await _repository.signup(name, email, password, age);
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false);
      final token = response.data?['createUserToken']?.toString();
      if (token != null) {
        appRouter.push(OtpRoute(createToken: token,argument: "signup"));
      } else {
        state = state.copyWith(error: "Token not found in response");
      }
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.logout();
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false, isAuthenticated: false);
      appRouter.replaceAll([const LoginRoute()]);
    }
  }

  Future<void> sendOtp(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.sendOtp(email);
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false);
      final token = response.data?['forgetToken']?.toString();
      if (token != null) {
        appRouter.push(OtpRoute(createToken: token,argument: "forget_password"));
      } else {
        state = state.copyWith(error: "Token not found in response");
      }
    }
  }

  Future<void> verifyOtp(String code, String token) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.verifyOtp(code, token);
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false, isAuthenticated: true);
      appRouter.push(CreatePasswordRoute(token: token));
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
    }
  }

  Future<void> verifyScreen(String code, String token) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.verifyOtp(code, token);
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false, isAuthenticated: true);
      appRouter.replaceAll([const LoginRoute()]);
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
    }
  }

  Future<void> createPassword(String newPassword, String confirmPassword,String token) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.createPassword(newPassword, confirmPassword,token);
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false, isAuthenticated: true);
      appRouter.replaceAll([const LoginRoute()]);
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
