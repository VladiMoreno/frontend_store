import 'package:frontend_store/middlewares/navigator.middleware.dart';
import 'package:frontend_store/modules/dashboard/dashboard.view.dart';
import 'package:frontend_store/modules/home/home.view.dart';
import 'package:frontend_store/modules/products/product.view.dart';
import 'package:frontend_store/modules/scanner/scanner.view.dart';
import 'package:frontend_store/modules/users/user.view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const home = '/home';
  static const scanner = '/scanner';
  static const dashboard = '/dashboard';
  static const products = '/products';
  static const users = '/users';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => HomeView(),
    ),
    GetPage(
      name: scanner,
      page: () => ScannerView(),
      /*middlewares: [
        NavigatorMiddleware(),
      ],*/
    ),
    GetPage(
      name: dashboard,
      page: () => DashboardView(),
      /*middlewares: [
        NavigatorMiddleware(),
      ],*/
    ),
    GetPage(
      name: products,
      page: () => ProductView(),
      /*middlewares: [
        NavigatorMiddleware(),
      ],*/
    ),
    GetPage(
      name: users,
      page: () => UserView(),
      /*middlewares: [
        NavigatorMiddleware(),
      ],*/
    ),
  ];
}
