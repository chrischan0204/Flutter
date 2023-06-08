import '/common_libraries.dart';

class UsageView extends StatelessWidget {
  const UsageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: lightGreenAccent,
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              'Usage',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Used In:   ',
                      children: [
                        TextSpan(
                          text: '13 Audits',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Last Used:   ',
                      children: [
                        TextSpan(
                          text: 'Audit # 028-19939',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Last Used By:   ',
                      children: [
                        TextSpan(
                          text: 'Andrew Gardner',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Last used Audit Status:   ',
                      children: [
                        TextSpan(
                          text: 'In review',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
