import 'package:flutter/material.dart';
import 'package:frontend_store/common/widgets/layout.view.dart';
import 'package:frontend_store/common/widgets/loading.view.dart';
import 'package:get/get.dart';

import 'user.controller.dart';

class UserView extends StatefulWidget {
  UserView({super.key});

  final UserController controller = UserController();

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.controller.isLoading.isTrue
          ? const LoadingView()
          : LayoutView(
              screenToShow: const Placeholder(),
            ),
    );
  }
}
