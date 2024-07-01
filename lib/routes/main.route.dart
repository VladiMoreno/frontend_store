import 'package:frontend_store/modules/home/home.view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const home = '/home';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => HomeView(),
    ),
  ];
}
