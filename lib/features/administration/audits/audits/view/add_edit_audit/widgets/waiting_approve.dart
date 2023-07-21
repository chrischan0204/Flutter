import '/common_libraries.dart';

class WaitingApproveEditAuditView extends StatelessWidget {
  final String auditNumber;
  const WaitingApproveEditAuditView({
    super.key,
    required this.auditNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: inset12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: inset20,
              child: Text(
                'One moment please...',
                style: textSemiBold18,
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBottomBorderContainer(
                  padding: inset20,
                  backgroundColor: lightGreen,
                  child: Text(
                    'Updating - $auditNumber',
                    style: textSemiBold18,
                  ),
                ),
                CustomBottomBorderContainer(
                  padding: inset20,
                  child: Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomBottomBorderContainer(
                              padding: insety20,
                              alignment: Alignment.center,
                              child: Text(
                                'We are updating audit. Please do not click the back button.',
                                style: textSemiBold14,
                              ),
                            ),
                            CustomBottomBorderContainer(
                              padding: insety40,
                              child: Image.asset(
                                'assets/images/loading.gif',
                                height: MediaQuery.of(context).size.height / 3,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Container(
                              padding: insety20,
                              alignment: Alignment.center,
                              child: Text(
                                'We are updating audit. Please do not click the back button.',
                                style: textSemiBold14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
