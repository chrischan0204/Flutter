import '/common_libraries.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: insety12,
      child: Text(
        description,
        style: textSemiBold12,
      ),
    );
  }
}
