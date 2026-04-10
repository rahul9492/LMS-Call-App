// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authService)
const authServiceProvider = AuthServiceProvider._();

final class AuthServiceProvider
    extends $FunctionalProvider<AuthService, AuthService, AuthService>
    with $Provider<AuthService> {
  const AuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authServiceHash();

  @$internal
  @override
  $ProviderElement<AuthService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthService create(Ref ref) {
    return authService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthService>(value),
    );
  }
}

String _$authServiceHash() => r'21d842d4dceafa3d239c0196a0f2b890d37c0b71';

/// Holds the current authenticated user (null = logged out).
///
/// State: AsyncValue<AuthUser?> — use [authNotifierProvider]

@ProviderFor(AuthNotifier)
const authProvider = AuthNotifierProvider._();

/// Holds the current authenticated user (null = logged out).
///
/// State: AsyncValue<AuthUser?> — use [authNotifierProvider]
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, AuthUser?> {
  /// Holds the current authenticated user (null = logged out).
  ///
  /// State: AsyncValue<AuthUser?> — use [authNotifierProvider]
  const AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();
}

String _$authNotifierHash() => r'31d8242b5d1df57e8510f0d41b1690f6f0586f66';

/// Holds the current authenticated user (null = logged out).
///
/// State: AsyncValue<AuthUser?> — use [authNotifierProvider]

abstract class _$AuthNotifier extends $AsyncNotifier<AuthUser?> {
  FutureOr<AuthUser?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthUser?>, AuthUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthUser?>, AuthUser?>,
              AsyncValue<AuthUser?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
