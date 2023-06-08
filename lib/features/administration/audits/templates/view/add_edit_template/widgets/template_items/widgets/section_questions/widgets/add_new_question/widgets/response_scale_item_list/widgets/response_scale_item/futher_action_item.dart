import '/common_libraries.dart';

class FutherActionItemView extends StatelessWidget {
  final String title;
  final bool active;
  final Color activeColor;
  final ValueChanged<bool> onClick;
  const FutherActionItemView({
    super.key,
    required this.title,
    required this.activeColor,
    required this.active,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onClick(!active),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor:
            active ? activeColor : const Color.fromRGBO(153, 153, 153, 1),
      ),
      child: Text(title),
    );
  }
}
