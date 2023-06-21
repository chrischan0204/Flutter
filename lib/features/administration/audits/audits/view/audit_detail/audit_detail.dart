import 'package:safety_eta/features/administration/audits/audits/view/audit_detail/widgets/widgets.dart';

import '/common_libraries.dart';

class AuditDetailView extends StatelessWidget {
  final String auditId;
  const AuditDetailView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuditDetailBloc(context),
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
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailAuditSectionListLoaded(auditId: widget.auditId));
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
          entity: state.audit,
          crudStatus: state.auditDeleteStatus,
          customDetailWidget: Column(
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
                            border: Border(bottom: BorderSide(color: grey))),
                        child: Text(
                          'SA0029-23',
                          style: textNormal20,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: SectionSummaryView()),
                          spacerx5,
                          Expanded(
                              child: Column(
                            children: [
                              AuditDetailItemView(
                                label: 'Owner',
                                content: 'Amy Admas',
                              ),
                              AuditDetailItemView(
                                label: 'Last touched',
                                content: '16th May 2023',
                              ),
                              AuditDetailItemView(
                                label: 'Sections',
                                content: '4',
                              ),
                              AuditDetailItemView(
                                label: 'Site',
                                content: 'Lakeshore Drive, Chicago',
                              ),
                              AuditDetailItemView(
                                label: 'Completion',
                                content: '33% (11 of 33)',
                                color: lightBlueAccent,
                              ),
                              AuditDetailItemView(
                                label: 'Observations',
                                content: '2',
                                color: lightBlueAccent,
                              ),
                            ],
                          )),
                          spacerx5,
                          Expanded(
                              child: Column(
                            children: [
                              AuditDetailItemView(
                                label: 'Created on',
                                content: '14th May 2023',
                              ),
                              AuditDetailItemView(
                                label: 'Status',
                                content: 'In progress',
                              ),
                              AuditDetailItemView(
                                label: 'Questions',
                                content: '43',
                              ),
                              AuditDetailItemView(
                                label: 'Project',
                                content: '--',
                              ),
                              AuditDetailItemView(
                                label: 'Action items',
                                content: '4',
                                color: lightBlueAccent,
                              ),
                              AuditDetailItemView(
                                label: 'Images',
                                content: '4',
                                color: lightBlueAccent,
                              ),
                            ],
                          )),
                          spacerx5,
                          Expanded(
                              child: Column(
                            children: [
                              AuditDetailItemView(
                                label: 'Area',
                                content: 'Section 3 Parking garage',
                              ),
                              AuditDetailItemView(
                                label: 'Companies',
                                content:
                                    'Lucas Landscaping, Constellation Fencing and picketing llc., Rider group concrete inc and Gartner Electric',
                                twoLines: true,
                              ),
                              AuditDetailItemView(
                                label: 'Inspectors',
                                content: 'Frank Hurt, Brian Trippi and George Kiltman',
                                twoLines: true,
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              spacery20,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: AuditSectionsView()),
                  spacerx10,
                  Expanded(
                    flex: 3,
                    child: QuestionsListView(),
                  ),
                ],
              ),
            ],
          ),
          // descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }
}
