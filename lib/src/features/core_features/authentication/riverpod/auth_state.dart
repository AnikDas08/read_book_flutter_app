class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final bool otpLoading;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.otpLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      otpLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
