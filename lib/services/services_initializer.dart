import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../core/theme/theme_service.dart';
import 'auth_service.dart';
import 'recipe_service.dart';
import 'pantry_service.dart';

import 'notification_service.dart'; // Added notification service

/// Helper class to initialize all services with the Indonesian mock data
class ServicesInitializer {
  /// Create and initialize all service providers for the app
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(create: (_) => ThemeService(), lazy: false),
      ChangeNotifierProvider(create: (_) => AuthService(), lazy: false),
      ChangeNotifierProvider(create: (_) => RecipeService()),
      ChangeNotifierProvider(create: (_) => PantryService()),
      ChangeNotifierProvider(
        create:
            (_) => NotificationService(), // Added notification service provider
      ),
    ];
  }

  /// Initialize all services with mock data
  static Future<void> initializeServices(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final recipeService = Provider.of<RecipeService>(context, listen: false);
    final pantryService = Provider.of<PantryService>(context, listen: false);
    final notificationService = Provider.of<NotificationService>(
      context,
      listen: false,
    );

    await authService.checkAuth();
    await recipeService.initialize();
    await pantryService.initialize();
    await notificationService.initialize();

    debugPrint('All services initialized with Indonesian mock data');
  }
}
