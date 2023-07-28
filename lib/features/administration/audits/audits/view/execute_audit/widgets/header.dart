import '/common_libraries.dart';

class ExecuteAuditHeaderView extends StatelessWidget {
  const ExecuteAuditHeaderView({
    super.key,
    required this.auditId,
  });

  final String auditId;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: insetx24y12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<AuditDetailBloc, AuditDetailState>(
              builder: (context, state) {
                return Text(
                  'Execute Audit - ${state.auditSummary?.name ?? ''}',
                  style: textSemiBold18,
                );
              },
            ),
            Row(
              children: [
                CustomButton(
                  backgroundColor: purpleColor,
                  hoverBackgroundColor: purpleHoverColor,
                  iconData: PhosphorIcons.regular.aperture,
                  text: 'Focus Mode',
                  onClick: () => CustomAlert.checkFormDirty(
                      () => GoRouter.of(context)
                          .go('/audits/focus_mode/$auditId'),
                      context),
                ),
                spacerx20,
                CustomButton(
                  backgroundColor: successColor,
                  hoverBackgroundColor: successHoverColor,
                  iconData: PhosphorIcons.regular.caretCircleDoubleRight,
                  text: 'Audit Details',
                  onClick: () => CustomAlert.checkFormDirty(
                      () => GoRouter.of(context).go('/audits/show/$auditId'),
                      context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
