import '/common_libraries.dart';

class FutherActionItemView extends StatelessWidget {
  final String title;
  final bool active;
  final Color activeColor;
  final bool disabled;
  final ValueChanged<bool> onClick;
  const FutherActionItemView({
    super.key,
    required this.title,
    required this.activeColor,
    required this.active,
    required this.disabled,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : () => onClick(!active),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: active ? primaryColor : disableColor,
          border: Border.all(color: grey),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
