import '/common_libraries.dart';
import 'widgets/widgets.dart';

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
      ..add(AuditDetailAuditSectionListLoaded());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<ThemeBloc>().add(const ThemeSidebarItemExtended(
          collapsedItem: 'audits/show',
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
          entity: state.auditSummary?.audit,
          crudStatus: state.auditDeleteStatus,
          customDetailWidget: state.auditSummary == null
              ? const Center(child: Loader())
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: inset10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: inset20,
                              decoration: BoxDecoration(
                                  border:
                                      Border(bottom: BorderSide(color: grey))),
                              child: Text(
                                '${state.auditSummary?.auditNumber}',
                                style: textNormal20,
                              ),
                            ),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 2, child: SectionSummaryView()),
                                Expanded(flex: 1, child: AuditDetailView1()),
                                Expanded(flex: 1, child: AuditDetailView2()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    spacery20,
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: AuditSectionsView()),
                          Expanded(
                            flex: 3,
                            child: QuestionsListView(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          showSecondaryButton: true,
          secondaryButtonOnClick: () =>
              context.go('/audits/execute/${widget.auditId}'),
          secondaryIcon: PhosphorIcons.regular.caretCircleDoubleRight,
          secondaryLabel: 'Excute Audit',
        );
      },
    );
  }
}
