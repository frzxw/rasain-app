import 'dart:io';

import 'package:flutter/widgets.dart';

Widget localFileImage(
  String path, {
  BoxFit? fit,
  double? width,
  double? height,
}) {
  return Image.file(
    File(path),
    fit: fit,
    width: width,
    height: height,
  );
}
