import 'package:frontend_store/middlewares/admin.middleware.dart';
import 'package:frontend_store/middlewares/general.middleware.dart';
import 'package:frontend_store/middlewares/login.middleware.dart';
import 'package:frontend_store/middlewares/navigator.middleware.dart';
import 'package:frontend_store/modules/carts/carts.view.dart';
import 'package:frontend_store/modules/dashboard/dashboard.view.dart';
import 'package:frontend_store/modules/home/home.view.dart';
import 'package:frontend_store/modules/login/login.view.dart';
import 'package:frontend_store/modules/products/product.view.dart';
import 'package:frontend_store/modules/scanner/scanner.view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const home = '/home';
  static const scanner = '/scanner';
  static const dashboard = '/dashboard';
  static const products = '/products';
  static const carts = '/carts';
  static const login = '/login';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => HomeView(),
    ),
    GetPage(
      name: login,
      page: () => const LoginView(),
      middlewares: [
        //NavigatorMiddleware(),
        LoginMiddleware(),
      ],
    ),
    GetPage(
      name: scanner,
      page: () => ScannerView(),
      middlewares: [
        //NavigatorMiddleware(),
        GeneralMiddleware(),
      ],
    ),
    GetPage(
      name: dashboard,
      page: () => DashboardView(),
      middlewares: [
        //NavigatorMiddleware(),
        AdminMiddleware(),
      ],
      children: [
        GetPage(
          name: products,
          page: () => ProductView(),
        ),
        GetPage(
          name: carts,
          page: () => CartsView(),
        ),
      ],
    ),
  ];
}
