import '../../../../../../../../common_libraries.dart';
import 'widgets/widgets.dart';

class SummaryView extends StatefulWidget {
  final String auditId;
  const SummaryView({
    super.key,
    required this.auditId,
  });

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  @override
  void initState() {
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailLoaded(auditId: widget.auditId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          if (state.auditSummary != null) {
            final audit = state.auditSummary!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBottomBorderContainer(
                  padding: inset20,
                  child: Text(
                    audit.auditNumber ?? '',
                    style: textSemiBold20,
                  ),
                ),
                Padding(
                  padding: inset20,
                  child: Row(
                    children: [
                      const Spacer(),
                      SummaryItemView(
                        title: 'Answered',
                        content:
                            '${audit.answeredQuestions} of ${audit.questions} Questions',
                      ),
                      const Spacer(flex: 1),
                      SummaryItemView(
                        title: 'Score      ',
                        content:
                            '${audit.score} pts ${audit.completedPercent}%',
                      ),
                      const Spacer(flex: 1),
                      SummaryItemView(
                        title: 'Started on      ',
                        content: audit.formatedAuditDate,
                      ),
                      const Spacer(flex: 1),
                      SummaryItemView(
                        title: 'Last executed on',
                        content: audit.formatedLastExecutedOn,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
