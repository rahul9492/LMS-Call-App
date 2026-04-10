import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/auth_model.dart';
import '../../../data/services/auth_service.dart';

part 'auth_providers.g.dart';

// ── Service provider ──────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) => AuthService();

// ── Auth state notifier ───────────────────────────────────────────────────────

/// Holds the current authenticated user (null = logged out).
///
/// State: AsyncValue<AuthUser?> — use [authNotifierProvider]
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthUser?> build() async {
    return ref.read(authServiceProvider).loadUser();
  }

  /// Sends OTP to [mobileNumber]. Call this from the login screen.
  /// Returns the OTP code in local mode (null when using a real SMS API).
  Future<String?> requestOtp(String mobileNumber) async {
    return ref.read(authServiceProvider).requestOtp(mobileNumber);
  }

  /// Verifies [otp] for [mobileNumber].
  /// Returns true on success (state updates to authenticated user).
  Future<bool> verifyOtp(String mobileNumber, String otp) async {
    final svc = ref.read(authServiceProvider);
    final user = await svc.verifyOtp(mobileNumber, otp);
    if (user == null) return false;
    await svc.saveUser(user);
    state = AsyncValue.data(user);
    return true;
  }

  /// Clears auth state and SharedPreferences. Call this from settings.
  Future<void> logout() async {
    await ref.read(authServiceProvider).clearUser();
    state = const AsyncValue.data(null);
  }
}
