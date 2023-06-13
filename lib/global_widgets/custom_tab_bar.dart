import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final int activeIndex;
  final Map<String, Widget> tabs;
  final ValueChanged<int> onTabClick;
  const CustomTabBar({
    super.key,
    required this.activeIndex,
    required this.tabs,
    required this.onTabClick,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: List.generate(
              widget.tabs.length,
              (index) => CustomTabBarItem(
                active: index == _activeIndex,
                name: widget.tabs.keys.toList()[index],
                onClick: () {
                  setState(() => _activeIndex = index);
                  widget.onTabClick(index);
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: widget.tabs[widget.tabs.keys.toList()[_activeIndex]],
        ),
      ],
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
    } else if (!widget.active && _hover) {
      return Colors.black.withOpacity(0.6);
    }
    return Colors.transparent;
  }

  FontWeight _getTextFontWeight() {
    if (widget.active) {
      return FontWeight.bold;
    }
    return FontWeight.normal;
  }

  Color _getTextColor() {
    if (widget.active) {
      return Colors.black;
    } else if (!widget.active && _hover) {
      return Colors.black.withOpacity(0.9);
    }
    return Colors.black.withOpacity(0.6);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: widget.onClick,
        onHover: (value) => setState(() => _hover = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _getBorderColor(),
                width: 2,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              widget.name,
              style: TextStyle(
                fontWeight: _getTextFontWeight(),
                color: _getTextColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
