import 'package:flutter/material.dart';
import 'package:frontend_store/utils/get_size.util.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        GetSize.init(context);
        return child;
      },
    );
  }
}
