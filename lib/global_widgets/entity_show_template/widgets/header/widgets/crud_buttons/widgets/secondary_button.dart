import '/common_libraries.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onClick;
  const SecondaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Tooltip(
      message: width > minDesktopWidth ? '' : label,
      child: CustomButton(
        backgroundColor: successColor,
        hoverBackgroundColor: successHoverColor,
        iconData: icon,
        text: label,
        isOnlyIcon: width < minDesktopWidth,
        onClick: onClick,
      ),
    );
  }
}
