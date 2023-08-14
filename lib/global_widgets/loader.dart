import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  final double size;
  final double topPadding;
  const Loader({
    super.key,
    this.size = 70,
    this.topPadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: LoadingAnimationWidget.hexagonDots(
        color: const Color(0xff8d8c91),
        size: size,
      ),
    );
  }
}
