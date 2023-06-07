import 'package:strings/strings.dart';

import '/common_libraries.dart';

class GoToEditButton extends StatelessWidget {
  final String label;
  const GoToEditButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      backgroundColor: warnColor,
      hoverBackgroundColor: warnHoverColor,
      iconData: PhosphorIcons.regular.gear,
      text: 'Edit ${camelize(label)}',
      onClick: () => GoRouter.of(context).go(
        GoRouter.of(context).location.replaceAll('show', 'edit'),
      ),
    );
  }
}
