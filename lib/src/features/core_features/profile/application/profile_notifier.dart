import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/profile/application/profile_state.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/profile/infrastructure/profile_repository.dart';

final profileNotifierProvider = NotifierProvider<ProfileNotifier, ProfileState>(ProfileNotifier._);

class ProfileNotifier extends Notifier<ProfileState> {
  ProfileNotifier._();
  late ProfileRepository _repository;

  @override
  ProfileState build() {
    _repository = ref.read(profileRepositoryProvider);
    return const ProfileState();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.getProfile();
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false, profileData: response.data);
    }
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? email,
    String? photoPath,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.updateProfile(
      name: name,
      phone: phone,
      email: email,
      photoPath: photoPath,
    );
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false);
      await loadProfile();
      appRouter.back();
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.changePassword(oldPassword, newPassword);
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false);
      appRouter.back();
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
