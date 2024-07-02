import 'package:flutter/material.dart';
import 'package:frontend_store/utils/get_size.util.dart';

class LayoutView extends StatefulWidget {
  final Widget screenToShow;

  const LayoutView({
    super.key,
    required this.screenToShow,
  });

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              constraints: BoxConstraints(
                minWidth: GetSize.width,
                minHeight: GetSize.height * .9,
              ),
              child: SingleChildScrollView(
                child: widget.screenToShow,
              ),
            ),
          ),
        );
      },
    );
  }
}
