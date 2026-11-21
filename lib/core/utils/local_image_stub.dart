import 'package:flutter/widgets.dart';

/// Web builds never read a local file path. Callers already preview bytes.
Widget localFileImage(
  String path, {
  BoxFit? fit,
  double? width,
  double? height,
}) {
  return const SizedBox.shrink();
}
