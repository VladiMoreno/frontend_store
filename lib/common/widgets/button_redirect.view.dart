import 'package:flutter/material.dart';
import 'package:frontend_store/common/styles/custom_text.style.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:get/get.dart';

class ButtonRedirectView extends StatelessWidget {
  final String text;
  final String? url;

  const ButtonRedirectView({
    super.key,
    required this.text,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (url != null) {
          Get.toNamed(url!);
        }
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
        child: CustomText(text: text),
      ),
    );
  }
}
