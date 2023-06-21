import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UrlUtil {
  static String getPath(BuildContext context) {
    final pathSegments = Uri.parse(GoRouter.of(context).location).pathSegments;
    String second = '';
    if (pathSegments.length > 1 && pathSegments[1] != 'index') {
      second = '/${pathSegments[1]}';
    }

    return '${pathSegments[0]}$second';
  }
}
