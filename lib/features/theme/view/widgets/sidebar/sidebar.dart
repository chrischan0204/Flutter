import '../../../data/model/model.dart';
import '/common_libraries.dart';

import '../../../data/repository/repository.dart';
import 'sidebar_style.dart';
import 'widgets/collapse_button.dart';

import 'widgets/criteria.dart';
import 'widgets/header.dart';
import 'widgets/sidebar_item.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({
    super.key,
    required this.selectedItemName,
  });

  final String selectedItemName;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<Widget> _buildSidebarItems(
    List<SidebarItemModel> items,
    String selectedItemName,
    bool isSidebarExtended,
  ) {
    List<Widget> subItemWidgets = [];
    for (int i = 0; i < items.length; i++) {
      subItemWidgets.add(
        SidebarItem(
          iconData: items[i].iconData,
          label: items[i].label,
          path: items[i].path,
          color: items[i].color,
          selectedItemName: selectedItemName,
          isSidebarExtended: isSidebarExtended,
          subItems: items[i].subItems,
        ),
      );
    }
    return subItemWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (ctx, state) {
            final isSidebarExtended =
                context.read<ThemeBloc>().state.isExtended(context);
            return Stack(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  decoration: BoxDecoration(
                    color: sidebarColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  width: isSidebarExtended ? sidebarWidth : shrinkSidebarWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: isSidebarExtended
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Header(
                          isSidebarExtended: isSidebarExtended,
                          userName: authState.authUser?.name ?? '',
                        ),
                        Divider(
                          color: backgroundColor,
                          thickness: 0.5,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: Criteria(
                            isSidebarExtended: isSidebarExtended,
                            label: 'MAIN',
                          ),
                        ),
                        ..._buildSidebarItems(
                          SidebarRepsitory.mainItems,
                          widget.selectedItemName,
                          isSidebarExtended,
                        ),
                        Divider(
                          color: backgroundColor,
                          thickness: 0.5,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: Criteria(
                            isSidebarExtended: isSidebarExtended,
                            label: 'ADMINISTRATION',
                          ),
                        ),
                        ..._buildSidebarItems(
                          SidebarRepsitory.administrationItems,
                          widget.selectedItemName,
                          isSidebarExtended,
                        ),
                        Divider(
                          color: backgroundColor,
                          thickness: 0.5,
                        ),
                        ..._buildSidebarItems(
                          SidebarRepsitory.profileItems,
                          widget.selectedItemName,
                          isSidebarExtended,
                        )
                      ],
                    ),
                  ),
                ),
                CollapseButton(
                  isSidebarExtended: isSidebarExtended,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
