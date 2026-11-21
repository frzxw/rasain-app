import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/auth_service.dart';
import '../../cubits/auth/auth_cubit.dart';
import 'demo_config.dart';

class AuthListener {
  final AuthService _authService;
  final AuthCubit _authCubit;

  AuthListener(this._authService, this._authCubit) {
    if (DemoConfig.enabled) return;
    _initializeAuthListener();
  }

  void _initializeAuthListener() {
    debugPrint('AuthListener: Initializing auth state listener');

    // Listen to Supabase auth state changes
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      debugPrint('AuthListener: Auth state changed - Event: $event');

      switch (event) {
        case AuthChangeEvent.signedIn:
          debugPrint('AuthListener: User signed in via deep link or direct');
          _handleSignedIn(session);
          break;
        case AuthChangeEvent.signedOut:
          debugPrint('AuthListener: User signed out');
          _handleSignedOut();
          break;
        case AuthChangeEvent.tokenRefreshed:
          debugPrint('AuthListener: Token refreshed');
          break;
        case AuthChangeEvent.userUpdated:
          debugPrint('AuthListener: User updated');
          break;
        case AuthChangeEvent.passwordRecovery:
          debugPrint('AuthListener: Password recovery');
          break;
        default:
          debugPrint('AuthListener: Unknown auth event: $event');
      }
    });
  }

  void _handleSignedIn(Session? session) {
    if (session?.user != null) {
      debugPrint('AuthListener: Processing sign in for user: ${session!.user.id}');

      // Force refresh the auth service to load user profile
      _authService
          .checkAuth()
          .then((_) {
            debugPrint('AuthListener: Auth service updated after sign in');
            // Notify AuthCubit to refresh its state
            _authCubit.handleAuthStateChange();
          })
          .catchError((error) {
            debugPrint('AuthListener: Error updating auth service: $error');
          });
    }
  }

  void _handleSignedOut() {
    debugPrint('AuthListener: Processing sign out');
    // Auth service will handle this automatically through its own listener
  }
}
