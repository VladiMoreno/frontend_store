import 'package:flutter/material.dart';
import 'package:frontend_store/common/widgets/responsive_wrapper.view.dart';
import 'package:frontend_store/config/states.config.dart';
import 'package:frontend_store/modules/home/home.view.dart';
import 'package:frontend_store/routes/main.route.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:frontend_store/utils/get_storage.util.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  final appStates = AppStates();
  await StorageService.init();
  appStates.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    GetSize.init(context);
    return ResponsiveWrapper(
      child: GetMaterialApp(
        title: 'STORE - Vladimir Moreno',
        initialRoute: '/login',
        getPages: AppRoutes.routes,
        unknownRoute: GetPage(
          name: '/home',
          page: () => HomeView(),
        ),
      ),
    );
  }
}
