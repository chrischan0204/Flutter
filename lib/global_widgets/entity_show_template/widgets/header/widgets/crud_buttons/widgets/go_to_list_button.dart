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
    return CustomButton(
      backgroundColor: primaryColor,
      hoverBackgroundColor: primaryHoverColor,
      iconData: PhosphorIcons.listNumbers,
      text: '${camelize(label)} List',
      onClick: () {
        String location = GoRouter.of(context).location;
        location = location.replaceRange(location.indexOf('show'), null, '');
        GoRouter.of(context).go(location);
      },
    );
    ;
  }
}
