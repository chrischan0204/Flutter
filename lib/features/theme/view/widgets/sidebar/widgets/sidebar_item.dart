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
  }) : super(key: key);

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem>
    with TickerProviderStateMixin {
  // late AnimationController animationController;
  // late Animation<double> anim;
  // late Animation<Color?> color;
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
    // animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(
    //     milliseconds: 350,
    //   ),
    // );

    // anim = Tween(
    //   begin: widget.isSidebarExtended ? sidebarWidth : shrinkSidebarWidth,
    //   end: 0.0,
    // ).animate(animationController);

    // color = ColorTween(
    //   end: widget.color,
    //   begin: backgroundColor,
    // ).animate(animationController);

    // animationController.addListener(() {
    //   setState(() {});
    // });
    // if (widget.selectedItemName != widget.path) {
    //   animationController.reverse();
    // } else {
    //   animationController.forward();
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // animationController.dispose();
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
        // animationController.duration = const Duration(milliseconds: 400);
        // anim = Tween(
        //   begin: widget.isSidebarExtended ? sidebarWidth : shrinkSidebarWidth,
        //   end: 0.0,
        // ).animate(animationController);

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
                      ..._buildSubItemsMenu(),
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
                child: _buildItemBody(state),
              ),
            ),
            ...(widget.isSidebarExtended && isSidebarItemExtended
                ? _buildSubItemsMenu()
                : []),
          ],
        );
      },
    );
  }

  List<Widget> _buildSubItemsMenu() {
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
            // margin: const EdgeInsets.only(top: 5),
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

  Widget _buildItemBody(ThemeState state) {
    return GestureDetector(
      onTap: () {
        if (widget.path.contains('logout')) {
          context.read<AuthBloc>().add(const AuthUnauthenticated());
        } else {
          if (widget.path.isNotEmpty) {
            if ('/${widget.path}' == GoRouter.of(context).location) {
              GoRouter.of(context).go('/${widget.path}/index');
            } else {
              GoRouter.of(context).go('/${widget.path}');
            }
          }

          setState(() {
            isSidebarItemExtended = !isSidebarItemExtended;
          });
        }
      },
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
          color: Colors.transparent,
          child: Stack(
            children: [
              // widget.isSidebarExtended
              //     ? CustomPaint(
              //         painter: CurvePainter(
              //           animValue: anim.value,
              //           width: sidebarWidth,
              //         ),
              //       )
              //     : widget.isSubItem
              //         ? SizedBox(
              //             width: sidebarWidth,
              //           )
              //         : CustomPaint(
              //             painter: CurvePainter(
              //               animValue: anim.value,
              //               width: shrinkSidebarWidth,
              //             ),
              //           ),
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double animValue;
  final double width;
  CurvePainter({
    required this.animValue,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.color = darkGrey;
    path.addRect(
      Rect.fromPoints(
        Offset(animValue, 0),
        Offset(
          width,
          sidebarItemHeight,
        ),
      ),
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
