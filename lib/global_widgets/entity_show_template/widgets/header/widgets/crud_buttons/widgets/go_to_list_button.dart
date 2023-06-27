import 'package:strings/strings.dart';

import '/common_libraries.dart';

class GoToListButton extends StatelessWidget {
  final String label;
  const GoToListButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Tooltip(
      message: width > minDesktopWidth ? '' : '${camelize(label)} List',
      child: CustomButton(
        backgroundColor: primaryColor,
        hoverBackgroundColor: primaryHoverColor,
        iconData: PhosphorIcons.regular.listNumbers,
        text: width < minDesktopWidth ? '' : '${camelize(label)} List',
        isOnlyIcon: width < minDesktopWidth,
        onClick: () {
          String location = GoRouter.of(context).location;
          location = location.replaceRange(location.indexOf('show'), null, '');
          GoRouter.of(context).go(location);
        },
      ),
    );
    ;
  }
}
