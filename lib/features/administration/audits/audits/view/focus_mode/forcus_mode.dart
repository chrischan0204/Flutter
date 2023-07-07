import '/common_libraries.dart';

class AuditFocusModeView extends StatelessWidget {
  final String auditId;
  const AuditFocusModeView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: inset12,
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
                  CustomButton(
                    backgroundColor: purpleColor,
                    hoverBackgroundColor: purpleHoverColor,
                    iconData: PhosphorIcons.regular.alignLeft,
                    text: 'Exit Focus Mode',
                    onClick: () =>
                        GoRouter.of(context).go('/audits/execute/$auditId'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Card(
              elevation: 3,
              child: Padding(
                padding: insetx12y24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomBottomBorderContainer(
                      padding: inset30,
                      child: Column(
                        children: [
                          Text(
                            'Audit Questions Selector',
                            style: textNormal18,
                          ),
                          spacery10,
                          Text(
                            'Select the questions to be presented in focused mode',
                            style: textNormal18,
                          )
                        ],
                      ),
                    ),
                    spacery30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: CustomSingleSelect(
                            hint: 'All Questions',
                            items: const {'All Questions': 'All Question'},
                            onChanged: (value) {},
                          ),
                        ),
                        spacerx100,
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(padding: insetx24y12),
                          child: Text(
                            'Start',
                            style: textNormal14.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
