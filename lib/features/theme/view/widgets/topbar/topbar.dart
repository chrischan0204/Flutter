import '/features/theme/view/widgets/sidebar/sidebar_style.dart';
import '/features/theme/view/widgets/topbar/topbar_widgets/logo.dart';
import '/features/theme/view/widgets/topbar/topbar_widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Topbar extends StatelessWidget {
  const Topbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: sidebarColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ...(MediaQuery.of(context).size.width < 1000
                  ? [
                      Builder(
                        builder: (context) => // Ensure Scaffold is in context
                            IconButton(
                          icon: Icon(
                            PhosphorIcons.list,
                            color: backgroundColor,
                            size: 20,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ]
                  : [
                      const SizedBox(
                        width: 20,
                      )
                    ]),
              const Logo()
            ],
          ),
          const SearchField(),
        ],
      ),
    );
  }
}
