import 'package:flutter/material.dart';
import 'package:frontend_store/common/styles/custom_text.style.dart';
import 'package:frontend_store/common/widgets/layout.view.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:get/get.dart';

import 'dashboard.controller.dart';

class DashboardView extends StatefulWidget {
  DashboardView({super.key});

  final DashboardController controller = DashboardController();

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return LayoutView(
      screenToShow: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed('/products');
            },
            child: Container(
              width: GetSize.width * .7,
              height: GetSize.height * .3,
              margin: EdgeInsets.symmetric(
                horizontal: GetSize.width * .05,
                vertical: GetSize.height * .05,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              alignment: Alignment.center,
              child: const CustomText(text: 'Gestión de productos'),
            ),
          ),
          Container(
            width: GetSize.width * .7,
            height: GetSize.height * .3,
            margin: EdgeInsets.symmetric(
              horizontal: GetSize.width * .05,
              vertical: GetSize.height * .05,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            alignment: Alignment.center,
            child: const CustomText(text: 'Gestión de usuarios'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/scanner');
            },
            child: Container(
              width: GetSize.width * .7,
              height: GetSize.height * .3,
              margin: EdgeInsets.symmetric(
                horizontal: GetSize.width * .05,
                vertical: GetSize.height * .05,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              alignment: Alignment.center,
              child: const CustomText(text: 'Realizar una compra'),
            ),
          ),
        ],
      ),
    );
  }
}
