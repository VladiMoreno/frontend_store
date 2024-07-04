import 'package:flutter/material.dart';
import 'package:frontend_store/utils/get_storage.util.dart';
import 'package:get/get.dart';

class AdminMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    String? isAdmin = StorageService().storage.read('user_type');
    switch (isAdmin) {
      case null:
        StorageService().storage.remove('user_type');
        return const RouteSettings(name: '/login');
      case '1':
        return null;
      default:
        StorageService().storage.remove('user_type');
        return const RouteSettings(name: '/login');
    }
  }
}
