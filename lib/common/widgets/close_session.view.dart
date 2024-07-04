import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend_store/common/styles/custom_text.style.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:frontend_store/utils/get_storage.util.dart';
import 'package:get/get.dart';

class CloseSessionView extends StatelessWidget {
  const CloseSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      padding: const EdgeInsets.only(left: 20),
      width: GetSize.width,
      height: 25,
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          StorageService().storage.remove('user_type');
          Get.offNamed('/login');
        },
        child: const Row(
          children: [
            FaIcon(FontAwesomeIcons.arrowLeftLong),
            SizedBox(width: 15),
            CustomText(text: 'Cerrar sesión'),
          ],
        ),
      ),
    );
  }
}
