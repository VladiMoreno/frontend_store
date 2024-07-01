import 'package:flutter/material.dart';

import 'home.controller.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  final HomeController controller = HomeController();

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
