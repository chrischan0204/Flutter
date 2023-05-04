import 'package:safety_eta/common_libraries.dart';
import 'package:safety_eta/features/features.dart';

import '/features/theme/view/widgets/topbar/topbar.dart';
import 'package:flutter/material.dart';

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

  late AuthBloc _authBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    scaffoldKey.currentState?.openDrawer();
    _authBloc = context.read<AuthBloc>();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_authBloc.state.token.isEmpty ||
        _authBloc.state is AuthUnauthenticateSuccess) {
      GoRouter.of(context).go('/login');
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticateSuccess) {
          if (state.statusCode == 401) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.info,
              content: 'Session has expired',
            ).showNotification();
          }
          GoRouter.of(context).go('/login');
        }
      },
      builder: (context, state) => state.token.isEmpty
          ? const LoginView()
          : LayoutBuilder(
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
                body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      const Topbar(),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            constraints.maxWidth < 1000
                                ? Container()
                                : Sidebar(
                                    selectedItemName: widget.selectedItemName,
                                  ),
                            Expanded(
                              child: widget.body,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
