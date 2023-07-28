import '/common_libraries.dart';

class ExecuteAuditHeaderView extends StatelessWidget {
  const ExecuteAuditHeaderView({
    super.key,
    required this.auditId,
  });

  final String auditId;

  void _checkFormDirty(
    VoidCallback function,
    BuildContext context,
  ) {
    if (context.read<FormDirtyBloc>().state.isDirty) {
      AwesomeDialog(
        context: context,
        width: MediaQuery.of(context).size.width / 4,
        dialogType: DialogType.question,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Confirm',
        dialogBorderRadius: BorderRadius.circular(5),
        desc: 'Data that was entered will be lost ..... Proceed?',
        buttonsTextStyle: const TextStyle(color: Colors.white),
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: function,
        btnOkText: 'Proceed',
        buttonsBorderRadius: BorderRadius.circular(3),
        padding: const EdgeInsets.all(10),
      ).show();
    } else {
      function();
    }
  }

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
                  onClick: () => _checkFormDirty(
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
                  onClick: () => _checkFormDirty(
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
