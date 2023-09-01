import '/common_libraries.dart';
import 'audit_detail_completed.dart';
import 'audit_detail_not_completed.dart';

class AuditDetailView extends StatelessWidget {
  final String auditId;
  const AuditDetailView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuditDetailBloc(
        context,
        auditId,
      ),
      child: AuditDetailWidget(auditId: auditId),
    );
  }
}

class AuditDetailWidget extends StatefulWidget {
  final String auditId;
  const AuditDetailWidget({
    super.key,
    required this.auditId,
  });

  @override
  State<AuditDetailWidget> createState() => _AuditDetailViewState();
}

class _AuditDetailViewState extends State<AuditDetailWidget> {
  static String pageTitle = 'Audit';
  static String pageLabel = 'Audit';

  @override
  void initState() {
    context.read<AuditDetailBloc>()
      ..add(AuditDetailLoaded(auditId: widget.auditId))
      ..add(AuditDetailAuditSectionListLoaded())
      ..add(AuditDetailDocumentListLoaded())
      ..add(AuditDetailActionItemListLoaded())
      ..add(AuditDetailObservationListLoaded());
    context.read<ThemeBloc>().add(const ThemeSidebarItemExtended(
          collapsedItem: 'audits/show',
          force: true,
        ));
    super.initState();
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
          deleteEntity: () {},
          entity: state.auditSummary?.audit,
          crudStatus: state.auditDeleteStatus,
          customDetailWidget: state.auditSummary == null
              ? const Center(child: Loader())
              : state.isEditable
                  ? AuditDetailForNotCompletedView(
                      auditNumber: state.auditSummary?.auditNumber ?? '')
                  : AuditDetailForCompletedView(
                      auditNumber: state.auditSummary?.auditNumber ?? ''),
          showSecondaryButton: state.isEditable,
          isEditable: state.isEditable,
          secondaryButtonOnClick: () =>
              context.go('/audits/execute/${widget.auditId}'),
          secondaryIcon: PhosphorIcons.regular.caretCircleDoubleRight,
          secondaryLabel: 'Excute Audit',
          isDeletable: state.isDeletable,
          onDeleteButtonClick: () =>
              context.go('/audits/approve_delete/${widget.auditId}'),
        );
      },
    );
  }
}
