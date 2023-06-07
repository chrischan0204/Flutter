import 'package:safety_eta/common_libraries.dart';

import '/features/theme/view/widgets/sidebar/sidebar_style.dart';
import '/features/theme/view/widgets/topbar/topbar_widgets/logo.dart';
import '/features/theme/view/widgets/topbar/topbar_widgets/search_field.dart';

class Topbar extends StatelessWidget {
  const Topbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: topbarHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: sidebarColor,
      ),
      padding: const EdgeInsets.only(right: 20),
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
                            PhosphorIcons.regular.list,
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
