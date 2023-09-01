import '../../../../../../common_libraries.dart';
import 'widgets/widgets.dart';

class AuditDetailForCompletedView extends StatelessWidget {
  final String auditNumber;
  const AuditDetailForCompletedView({
    super.key,
    required this.auditNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    auditNumber,
                    style: textNormal20,
                  ),
                ),
                const IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: SectionSummaryForCompletedView()),
                      Expanded(child: AuditDetail1CompletedView()),
                      Expanded(child: AuditDetail2CompletedView()),
                      Expanded(child: AuditDetail3CompletedView())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const ReviewsView(),
        const QuestionsAndAnswersView()
      ],
    );
  }
}
