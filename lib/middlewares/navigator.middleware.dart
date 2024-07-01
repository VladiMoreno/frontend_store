import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (kIsWeb) {
      return const RouteSettings(name: '/home');
    }
    return null;
  }
}
