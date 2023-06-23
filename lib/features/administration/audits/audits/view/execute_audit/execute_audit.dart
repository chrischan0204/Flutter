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
      padding: inset20,
      child: Column(
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: insetx24y12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Execute Audit',
                    style: textSemiBold18,
                  ),
                  Row(
                    children: [
                      CustomButton(
                        backgroundColor: purpleColor,
                        hoverBackgroundColor: purpleHoverColor,
                        iconData: PhosphorIcons.regular.aperture,
                        text: 'Focus Mode',
                        onClick: () => GoRouter.of(context)
                            .go('/audits/focus_mode/$auditId'),
                      ),
                      spacerx20,
                      CustomButton(
                        backgroundColor: successColor,
                        hoverBackgroundColor: successHoverColor,
                        iconData: PhosphorIcons.regular.caretCircleDoubleRight,
                        text: 'Audit Details',
                        onClick: () =>
                            GoRouter.of(context).go('/audits/show/$auditId'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          spacery10,
          Expanded(
            child: Column(
              children: const [
                SummaryView(),
                Expanded(child: AuditQuestionsView()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
