import 'package:flutter/material.dart';
import 'package:frontend_store/utils/get_storage.util.dart';
import 'package:get/get.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    String? verifyLogin = StorageService().storage.read('user_type');
    switch (verifyLogin) {
      case null:
        return null;
      case '1':
        return const RouteSettings(name: '/dashboard');
      case '2':
        return const RouteSettings(name: '/scanner');
      default:
        StorageService().storage.remove('user_type');
        return const RouteSettings(name: '/home');
    }
  }
}
