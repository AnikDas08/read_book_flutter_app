import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/profile/application/profile_state.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/profile/infrastructure/profile_repository.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/profile/model/profile_model.dart';

final profileNotifierProvider = NotifierProvider<ProfileNotifier, ProfileState>(ProfileNotifier.new);

class ProfileNotifier extends Notifier<ProfileState> {
  late ProfileRepository _repository;

  @override
  ProfileState build() {
    _repository = ref.read(profileRepositoryProvider);
    // Load profile on build
    Future.microtask(() => loadProfile());
    return const ProfileState();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.getProfile();
    if (response.isSuccess) {
      final profile = ProfileModel.fromJson(response.data);
      state = state.copyWith(isLoading: false, profile: profile);
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
    }
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? photoPath,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.updateProfile(
      name: name,
      phone: phone,
      photoPath: photoPath,
    );
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false);
      await loadProfile();
      appRouter.back();
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _repository.changePassword(oldPassword, newPassword);
    if (response.isSuccess) {
      state = state.copyWith(isLoading: false);
      appRouter.back();
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
