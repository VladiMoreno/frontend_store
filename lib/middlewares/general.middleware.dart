import 'package:flutter/material.dart';
import 'package:frontend_store/utils/get_storage.util.dart';
import 'package:get/get.dart';

class GeneralMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    String? isSeller = StorageService().storage.read('user_type');
    switch (isSeller) {
      case null:
        StorageService().storage.remove('user_type');
        return const RouteSettings(name: '/login');
      default:
        return null;
    }
  }
}