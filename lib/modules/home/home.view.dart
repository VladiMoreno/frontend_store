import 'package:flutter/material.dart';
import 'package:frontend_store/common/styles/custom_text.style.dart';
import 'package:frontend_store/common/widgets/loading.view.dart';
import 'package:frontend_store/config/env.config.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:get/get.dart';

import 'home.controller.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.controller.isLoading.isTrue
          ? const LoadingView()
          : SafeArea(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: GetSize.height,
                  maxWidth: GetSize.width,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: GetSize.width * .05,
                ),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Wrap(
                    children: List.generate(
                      widget.controller.info.length,
                      (index) {
                        final info = widget.controller.info[index];

                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          height: GetSize.height * .4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: GetSize.width * .2,
                                child: CustomText(
                                  text: info['name'],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Image.network(
                                imageUrl + info['barcode_image_path'],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
