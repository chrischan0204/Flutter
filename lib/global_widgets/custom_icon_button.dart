import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onClick;
  final Icon icon;
  const CustomIconButton({
    super.key,
    required this.onClick,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onClick(),
        child: icon,
      ),
    );
  }
}
