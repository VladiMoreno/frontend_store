import 'package:flutter/material.dart';
import 'package:frontend_store/common/styles/custom_text.style.dart';
import 'package:frontend_store/common/widgets/layout.view.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:frontend_store/utils/get_storage.util.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  loginAsAdmin() async {
    await StorageService().storage.write('user_type', '1');
    Get.offNamed('/dashboard');
  }

  loginAsSeller() async {
    await StorageService().storage.write('user_type', '2');
    Get.offNamed('/scanner');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutView(
      screenToShow: Container(
        constraints: BoxConstraints(
          minHeight: GetSize.height,
          maxWidth: GetSize.width,
        ),
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            const CustomText(text: 'Inicia sesión'),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                loginAsAdmin();
              },
              child: Container(
                width: GetSize.width * .7,
                height: GetSize.height * .3,
                margin: EdgeInsets.symmetric(
                  horizontal: GetSize.width * .05,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                alignment: Alignment.center,
                child: const CustomText(
                  text: 'Iniciar sesión como Admin',
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                loginAsSeller();
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
                child: const CustomText(
                  text: 'Iniciar sesión como Cajero',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
