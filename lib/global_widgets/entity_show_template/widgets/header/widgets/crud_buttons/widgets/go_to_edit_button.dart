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
    final width = MediaQuery.of(context).size.width;
    return Tooltip(
      message: width > minDesktopWidth ? '' : 'Edit ${camelize(label)}',
      child: CustomButton(
        backgroundColor: warnColor,
        hoverBackgroundColor: warnHoverColor,
        iconData: PhosphorIcons.regular.gear,
        text: 'Edit ${camelize(label)}',
        isOnlyIcon: width < minDesktopWidth,
        onClick: () => GoRouter.of(context).go(
          GoRouter.of(context).location.replaceAll('show', 'edit'),
        ),
      ),
    );
  }
}
