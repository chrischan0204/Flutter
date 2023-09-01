import '../../../../../../../common_libraries.dart';
import '../../widgets/detail_item.dart';
import 'action_item_list.dart';
import 'observation_list.dart';

class AuditDetail1CompletedView extends StatefulWidget {
  const AuditDetail1CompletedView({super.key});

  @override
  State<AuditDetail1CompletedView> createState() =>
      _AuditDetail1CompletedViewState();
}

class _AuditDetail1CompletedViewState extends State<AuditDetail1CompletedView> {
  @override
  void initState() {
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailAuditActionItemsStatsLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          final audit = state.auditSummary!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuditDetailItemView(
                label: 'Owner',
                content: audit.owner ?? '--',
              ),
              AuditDetailItemView(
                label: 'Completed On',
                content: audit.formatedLastExecutedOn,
              ),
              AuditDetailItemView(
                label: 'Score',
                content:
                    '${audit.answeredQuestions} of ${audit.questions} / (${audit.completedPercent}%)',
              ),
              AuditDetailItemView(
                label: 'Site',
                content: audit.siteName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Observations',
                highlighted: audit.observations != 0,
                content: audit.observations.toString(),
                onClick: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => AuditDetailObservationListView(
                        observationList: state.observationList),
                  );
                },
              ),
              CustomBottomBorderContainer(
                padding: inset10,
                child: Text(
                  'Action items',
                  style: textSemiBold14.copyWith(color: primaryColor),
                ),
              ),
              if (state.actionItemsStats != null)
                CustomBottomBorderContainer(
                  padding: inset10,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: insetx10,
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text('Total:'),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Builder(builder: (context) {
                                    bool highlighted =
                                        state.actionItemList.isNotEmpty;
                                    return MouseRegion(
                                      cursor: highlighted
                                          ? SystemMouseCursors.click
                                          : MouseCursor.defer,
                                      child: GestureDetector(
                                        onTap: highlighted
                                            ? () async {
                                                await showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder: (context) =>
                                                      AuditDetailActionItemListView(
                                                          actionItemList: state
                                                              .actionItemList),
                                                );
                                              }
                                            : null,
                                        child: Container(
                                          padding: inset0,
                                          decoration: highlighted
                                              ? BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                  color: primaryColor,
                                                  width: 1,
                                                )))
                                              : null,
                                          child: Text(
                                            state.actionItemsStats!.total
                                                .toString(),
                                            style: textNormal14.copyWith(
                                                color: highlighted
                                                    ? primaryColor
                                                    : null),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: insetx10,
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text('Closed:'),
                              ),
                              Expanded(
                                child: Text(
                                    state.actionItemsStats!.closed.toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: insetx10,
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text('Open:'),
                              ),
                              Expanded(
                                child: Text(
                                    state.actionItemsStats!.open.toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
