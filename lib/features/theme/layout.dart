import '/common_libraries.dart';
import '/features/theme/view/widgets/topbar/topbar.dart';

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
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      body: widget.body,
      selectedItemName: widget.selectedItemName,
    );
  }
}

class LayoutWidget extends StatefulWidget {
  final Widget body;
  final String selectedItemName;
  const LayoutWidget({
    super.key,
    required this.body,
    required this.selectedItemName,
  });

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  late ScrollController _scrollController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late AuthBloc _authBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    scaffoldKey.currentState?.openDrawer();
    _authBloc = context.read<AuthBloc>();
    context.read<FormDirtyBloc>().add(const FormDirtyChanged(isDirty: false));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_authBloc.state.authUser == null ||
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
      builder: (context, state) => state.authUser == null
          ? const LoginView()
          : LayoutBuilder(
              builder: (context, constraints) => InactivityDetectWidget(
                onShouldNavigate: (p0) {
                  _authBloc.add(const AuthUnauthenticated());
                  CustomNotification(
                    context: context,
                    notifyType: NotifyType.info,
                    content: 'Session has expired',
                  ).showNotification();
                },
                child: Scaffold(
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
                                      selectedItemName:
                                          widget.selectedItemName),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      topbarHeight,
                                  child: widget.body,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
