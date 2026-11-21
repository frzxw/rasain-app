import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/demo_config.dart';
import 'core/theme/colors.dart';
import 'core/theme/theme.dart';
import 'core/widgets/loading_screen.dart';
import 'routes.dart';

// Import cubits
import 'cubits/auth/auth_cubit.dart';
import 'cubits/recipe/recipe_cubit.dart';
import 'cubits/pantry/pantry_cubit.dart';
import 'cubits/notification/notification_cubit.dart';
import 'cubits/community/community_cubit.dart';

class RasainApp extends StatefulWidget {
  const RasainApp({super.key});

  @override
  State<RasainApp> createState() => _RasainAppState();
}

class _RasainAppState extends State<RasainApp> {
  bool _isLoading = true;
  String _loadingMessage = 'Memuat aplikasi...';
  String? _initError;
  late final GoRouter _router = createRouter();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    const maxAttempts = 3;
    Object? lastError;

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        if (!mounted) return;
        setState(() {
          _isLoading = true;
          _initError = null;
          _loadingMessage = 'Memuat autentikasi...';
        });
        await context.read<AuthCubit>().initialize();

        if (!mounted) return;
        setState(() {
          _loadingMessage = 'Memuat resep...';
        });
        await context.read<RecipeCubit>().initialize();

        if (!mounted) return;
        setState(() {
          _loadingMessage = 'Memuat pantry...';
        });
        await context.read<PantryCubit>().initialize();

        if (!mounted) return;
        setState(() {
          _loadingMessage = 'Memuat notifikasi...';
        });
        await context.read<NotificationCubit>().initialize();

        if (!mounted) return;
        setState(() {
          _loadingMessage = 'Memuat komunitas...';
        });
        await context.read<CommunityCubit>().initialize();

        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _initError = null;
        });
        return;
      } catch (e) {
        lastError = e;
        if (attempt == maxAttempts) break;
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _initError = lastError?.toString() ?? 'Gagal memuat aplikasi';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use a simplified theme approach with only light theme
    final ThemeData lightTheme = AppTheme.getLightTheme();

    return MaterialApp.router(
      title: 'Rasain',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerConfig: _router,
      builder: (context, child) {
        if (_isLoading) {
          return LoadingScreen(message: _loadingMessage);
        }
        if (_initError != null) {
          return _StartupError(
            message: _initError!,
            onRetry: _initializeApp,
          );
        }
        final page = child ?? const SizedBox.shrink();
        if (!DemoConfig.enabled) return page;
        return Column(
          children: [
            Material(
              color: AppColors.primary,
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 28,
                  child: Center(
                    child: const Text(
                      'Mode demo · data contoh, tanpa akun',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: page),
          ],
        );
      },
    );
  }
}

class _StartupError extends StatelessWidget {
  const _StartupError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 40, color: AppColors.primary),
              const SizedBox(height: 16),
              const Text(
                'Aplikasi belum bisa dimuat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(onPressed: onRetry, child: const Text('Coba lagi')),
            ],
          ),
        ),
      ),
    );
  }
}
