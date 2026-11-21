/// Compile-time switch for the web demo.
///
/// Build or run with `--dart-define=DEMO_MODE=true`. The app then uses the
/// sample data in `demo/demo_data.dart` and does not open a Supabase client.
class DemoConfig {
  static const bool enabled = bool.fromEnvironment('DEMO_MODE');
}
