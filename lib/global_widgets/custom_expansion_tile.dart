import 'package:safety_eta/common_libraries.dart';

class CustomExpansionTile extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  const CustomExpansionTile({
    super.key,
    required this.title,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: title,
      collapsedIconColor: children.isEmpty ? Colors.transparent : null,
      iconColor: children.isEmpty ? Colors.transparent : null,
      children: children,
      onExpansionChanged: (bool expanded) {},
    );
  }
}
