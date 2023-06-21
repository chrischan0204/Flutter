import '/common_libraries.dart';

class AuditDetailView extends StatefulWidget {
  final String auditId;
  const AuditDetailView({
    super.key,
    required this.auditId,
  });

  @override
  State<AuditDetailView> createState() => _AuditDetailViewState();
}

class _AuditDetailViewState extends State<AuditDetailView> {
  static String pageTitle = 'Audit';
  static String pageLabel = 'Audit';

  Map<String, Widget> get tabItems => {'': Container()};

  @override
  void initState() {
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailLoaded(auditId: widget.auditId));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<ThemeBloc>().add(ThemeSidebarItemExtended(
          collapsedItem: UrlUtil.getPath(context),
          force: true,
        ));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuditDetailBloc, AuditDetailState>(
      listener: (context, state) {
        if (state.auditDeleteStatus.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          GoRouter.of(context).go('/audits');
        }
        if (state.auditDeleteStatus.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) =>
          previous.auditDeleteStatus != current.auditDeleteStatus,
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => context
              .read<AuditDetailBloc>()
              .add(AuditDetailAuditDeleted(auditId: widget.auditId)),
          tabItems: tabItems,
          entity: state.audit,
          crudStatus: state.auditDeleteStatus,
          // descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }
}
