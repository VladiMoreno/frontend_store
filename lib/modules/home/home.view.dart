import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.controller.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.controller.isLoading.isTrue
          ? const Text('HOLA QUE TAL')
          : const Placeholder(),
    );
  }
}
