import '/features/theme/view/widgets/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'view/widgets/sidebar/sidebar.dart';
import 'view/widgets/sidebar/sidebar_style.dart';

class Layout extends StatefulWidget {
  const Layout({
    super.key,
    required this.body,
    required this.selectedItemName,
  });

  final Widget body;
  final String selectedItemName;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late ScrollController _scrollController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _scrollController = ScrollController();
    scaffoldKey.currentState?.openDrawer();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        drawerEnableOpenDragGesture: false,
        drawerScrimColor: Colors.transparent,
        drawer: constraints.maxWidth < 1000
            ? Drawer(
                width: sidebarWidth,
                backgroundColor: sidebarColor,
                child: Sidebar(
                  selectedItemName: widget.selectedItemName,
                ),
              )
            : null,
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            child: Column(
              children: [
                const Topbar(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    constraints.maxWidth < 1000
                        ? Container()
                        : Sidebar(
                            selectedItemName: widget.selectedItemName,
                          ),
                    Expanded(
                      child: SizedBox(
                        // height: constraints.maxHeight,
                        child: widget.body,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
