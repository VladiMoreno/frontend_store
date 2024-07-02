import 'package:flutter/material.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: GetSize.height,
        minWidth: GetSize.width,
      ),
      color: Colors.white,
      child: LoadingAnimationWidget.dotsTriangle(
        color: Colors.red,
        size: GetSize.height * .2,
      ),
    );
  }
}
