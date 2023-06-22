import '/common_libraries.dart';

class AssessmentFormItemView extends StatelessWidget {
  final String label;
  final Widget content;
  const AssessmentFormItemView({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset10,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: textSemiBold14,
            ),
          ),
          Expanded(
            flex: 2,
            child: content,
          )
        ],
      ),
    );
  }
}
