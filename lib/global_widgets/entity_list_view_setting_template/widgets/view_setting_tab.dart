import 'package:flutter/material.dart';

class ViewSettingTabView extends StatefulWidget {
  final ValueChanged<int> onChange;
  const ViewSettingTabView({
    super.key,
    required this.onChange,
  });

  @override
  State<ViewSettingTabView> createState() => _ViewSettingTabViewState();
}

class _ViewSettingTabViewState extends State<ViewSettingTabView> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 6,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: tabIndex == 0
                    ? const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      )
                    : BorderSide.none,
              ),
            ),
            child: TextButton(
              onPressed: () {
                widget.onChange(0);
                setState(() => tabIndex = 0);
              },
              child: Text(
                'Display',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      tabIndex == 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
            decoration: BoxDecoration(
              border: Border(
                bottom: tabIndex == 1
                    ? const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      )
                    : BorderSide.none,
              ),
            ),
            child: TextButton(
              onPressed: () {
                widget.onChange(1);
                setState(() => tabIndex = 1);
              },
              child: Text(
                'Sorting',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      tabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
