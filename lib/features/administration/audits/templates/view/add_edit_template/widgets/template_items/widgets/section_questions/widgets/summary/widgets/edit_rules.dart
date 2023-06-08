import '/common_libraries.dart';

class EditRulesView extends StatelessWidget {
  const EditRulesView({super.key});

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
              'Edit Rules',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Please note the following while making edits to the template',
            ),
          ),
          const CustomDivider(height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(PhosphorIcons.regular.dotOutline),
                    const SizedBox(width: 5),
                    const Expanded(
                        child: Text(
                      'Questions added to the template can be added in an audit as long as the audit is in Draft or in In progress status.',
                      maxLines: 2,
                    )),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(PhosphorIcons.regular.dotOutline),
                    const SizedBox(width: 5),
                    const Expanded(
                      child: Text(
                        'Questions deleted from the template will not impact any audit regardless of the status. A question that is in the audit will stay there even if it is deleted from the template.',
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(PhosphorIcons.regular.dotOutline),
                    const SizedBox(width: 5),
                    const Expanded(
                      child: Text(
                        'Questions edited in the template will not impact any audit regardless of the status. A question that is in the audit will stay there as is.',
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
