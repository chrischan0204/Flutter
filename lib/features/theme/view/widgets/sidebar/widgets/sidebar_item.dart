import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

import 'package:just_the_tooltip/just_the_tooltip.dart';

import '/common_libraries.dart';
import '../../../../data/model/model.dart';
import '../sidebar_style.dart';

class SidebarItem extends StatefulWidget {
  final IconData iconData;
  final String label;
  final String path;
  final String selectedItemName;
  final Color color;
  final bool isSidebarExtended;
  final List<SidebarItemModel> subItems;
  final bool isSubItem;
  final BuildContext context;
  const SidebarItem({
    Key? key,
    required this.iconData,
    required this.label,
    required this.path,
    required this.selectedItemName,
    required this.color,
    required this.isSidebarExtended,
    this.subItems = const [],
    this.isSubItem = false,
    required this.context,
  }) : super(key: key);

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem>
    with TickerProviderStateMixin {
  bool isHover = false;
  bool isSidebarItemExtended = false;
  CustomPopupMenuController customPopupMenuController =
      CustomPopupMenuController();
  final tooltipController = JustTheController();
  @override
  void initState() {
    super.initState();

    setState(() {
      isSidebarItemExtended = widget.subItems.map((e) => e.path).contains(
            widget.selectedItemName,
          );
    });
  }

  @override
  void dispose() {
    customPopupMenuController.dispose();
    tooltipController.dispose();
    super.dispose();
  }

  void _showPopupMenu(ThemeState state) {
    if (widget.subItems.isNotEmpty && !widget.isSidebarExtended) {
      customPopupMenuController.showMenu();
    }
  }

  void _hidePopupMenu(ThemeState state) {
    if (widget.subItems.isNotEmpty && !widget.isSidebarExtended) {
      customPopupMenuController.hideMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state.hoveredItemName != widget.label) {
          _hidePopupMenu(state);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPopupMenu(
              controller: customPopupMenuController,
              menuBuilder: () => MouseRegion(
                onExit: (event) {
                  _hidePopupMenu(state);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: sidebarColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                        ),
                        child: Text(
                          widget.label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ..._buildSubItemsMenu(widget.context),
                    ],
                  ),
                ),
              ),
              barrierColor: Colors.transparent,
              pressType: PressType.longPress,
              showArrow: false,
              horizontalMargin: shrinkSidebarWidth + 5,
              verticalMargin: -sidebarItemHeight - 30,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (event) {
                  setState(() {
                    isHover = true;
                  });
                },
                onExit: (event) {
                  setState(() {
                    isHover = false;
                  });
                },
                child: _buildItemBody(state, widget.subItems.isNotEmpty),
              ),
            ),
            ...(widget.isSidebarExtended && isSidebarItemExtended
                ? _buildSubItemsMenu(widget.context)
                : []),
          ],
        );
      },
    );
  }

  List<Widget> _buildSubItemsMenu(BuildContext context) {
    return widget.subItems
        .map(
          (subItem) => SidebarItem(
            iconData: subItem.iconData,
            label: subItem.label,
            path: subItem.path,
            selectedItemName: widget.selectedItemName,
            color: subItem.color,
            isSidebarExtended: widget.isSidebarExtended,
            isSubItem: true,
            context: widget.context,
          ),
        )
        .toList();
  }

  Widget _buildExtendIcon(ThemeState state) {
    return widget.isSidebarExtended && widget.subItems.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              isSidebarItemExtended
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: isSidebarItemExtended ? widget.color : backgroundColor,
              size: 28,
            ),
          )
        : Container();
  }

  Widget _buildIcon() {
    return !widget.isSidebarExtended &&
            widget.subItems.isEmpty &&
            !widget.isSubItem
        ? JustTheTooltip(
            controller: tooltipController,
            tailLength: 10.0,
            backgroundColor: sidebarColor,
            preferredDirection: AxisDirection.right,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.label,
                style: TextStyle(
                  color: backgroundColor,
                  fontSize: 14,
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Icon(
                widget.iconData,
                color: widget.color,
                size: 22,
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Icon(
              widget.iconData,
              color: widget.color,
              size: 22,
            ),
          );
  }

  Widget _buildLabel() {
    return widget.isSidebarExtended || widget.isSubItem
        ? Container(
            alignment: Alignment.center,
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : Container();
  }

  void _onClick() async {
    if (widget.path.isNotEmpty &&
        context.read<FormDirtyBloc>().state.isDirty &&
        !widget.path.contains('logout')) {
      try {
        await CustomAlert(
          context: widget.context,
          width: MediaQuery.of(widget.context).size.width / 4,
          dialogType: DialogType.question,
          title: 'Confirm',
          description: 'Data that was entered will be lost ..... Proceed?',
          btnCancelOnPress: () {},
          btnOkOnPress: () => _navigate(),
          btnOkText: 'Proceed',
        ).show();
      } catch (e) {}
    } else {
      _navigate();
    }
  }

  void _navigate() {
    if (widget.path.contains('logout')) {
      CustomAlert(
        context: widget.context,
        width: MediaQuery.of(widget.context).size.width / 4,
        title: 'Confirm',
        description: 'Do you really want to logout?',
        btnOkText: 'Logout',
        btnOkOnPress: () =>
            context.read<AuthBloc>().add(const AuthUnauthenticated()),
        btnCancelOnPress: () {},
        dialogType: DialogType.question,
      ).show();
    } else {
      if (widget.path.isNotEmpty) {
        if ('/${widget.path}' == GoRouter.of(widget.context).location) {
          widget.context.go('/${widget.path}/index');
        } else {
          widget.context.go('/${widget.path}');
        }

        widget.context
            .read<FormDirtyBloc>()
            .add(const FormDirtyChanged(isDirty: false));
      }
      if (mounted) {
        setState(() {
          isSidebarItemExtended = !isSidebarItemExtended;
        });
      }
    }
  }

  Widget _buildItemBody(ThemeState state, bool hasChildren) {
    return GestureDetector(
      onTap: () => _onClick(),
      child: MouseRegion(
        onEnter: (event) {
          if (!widget.isSubItem) {
            context.read<ThemeBloc>().add(
                  ThemeSidebarHovered(hoveredItemName: widget.label),
                );
            _showPopupMenu(state);
          }
        },
        child: Container(
          color: widget.selectedItemName == widget.path
              ? darkGrey
              : isHover
                  ? darkGrey
                  : Colors.transparent,
          height: sidebarItemHeight,
          width: sidebarWidth,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.only(
              left: (widget.isSidebarExtended ? 30 : 17) +
                  (widget.isSubItem ? 15 : 0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildIcon(),
                    widget.isSidebarExtended || widget.isSubItem
                        ? const SizedBox(
                            width: 10,
                          )
                        : Container(),
                    _buildLabel(),
                  ],
                ),
                _buildExtendIcon(state)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
