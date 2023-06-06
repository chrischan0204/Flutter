import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final int activeIndex;
  final List<String> nameList;
  const CustomTabBar({
    super.key,
    required this.activeIndex,
    required this.nameList,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _activeIndex = 0;
  @override
  void initState() {
    _activeIndex = widget.activeIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.nameList.length,
        (index) => CustomTabBarItem(
          active: index == _activeIndex,
          name: widget.nameList[index],
          onClick: () => setState(() => _activeIndex = index),
        ),
      ),
    );
  }
}

class CustomTabBarItem extends StatefulWidget {
  final bool active;
  final String name;
  final VoidCallback onClick;
  const CustomTabBarItem({
    super.key,
    required this.active,
    required this.name,
    required this.onClick,
  });

  @override
  State<CustomTabBarItem> createState() => _CustomTabBarItemState();
}

class _CustomTabBarItemState extends State<CustomTabBarItem> {
  bool _hover = false;

  Color _getBorderColor() {
    if (widget.active) {
      return Colors.black;
    } else if (widget.active && _hover) {
      return Colors.black.withOpacity(0.6);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      onHover: (value) => setState(() => _hover = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _getBorderColor(),
            ),
          ),
        ),
        curve: Curves.bounceOut,
        child: Text(
          widget.name,
          style: TextStyle(
              fontWeight: widget.active ? FontWeight.w600 : FontWeight.normal),
        ),
      ),
    );
  }
}
