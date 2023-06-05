import '/common_libraries.dart';

class TemplateDetailHeaderView extends StatelessWidget {
  final String title;
  const TemplateDetailHeaderView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
