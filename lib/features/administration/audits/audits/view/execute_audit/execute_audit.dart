import '../../../../../../common_libraries.dart';
import 'widgets/widgets.dart';

class ExecuteAuditView extends StatelessWidget {
  final String auditId;
  const ExecuteAuditView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: inset12,
      child: Column(
        children: [
          ExecuteAuditHeaderView(auditId: auditId),
          Expanded(
            child: Column(
              children: [
                BlocProvider(
                  create: (context) => AuditDetailBloc(context, auditId),
                  child: SummaryView(auditId: auditId),
                ),
                Expanded(child: AuditQuestionsView()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
