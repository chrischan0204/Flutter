import '/common_libraries.dart';

class EditAssessmentTitleView extends StatelessWidget {
  final String title;
  const EditAssessmentTitleView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: grey),
            top: BorderSide(color: grey),
          ),
        ),
        padding: inset12,
        margin: insety2,
        child: Text(
          '$title:',
          style: textSemiBold14.copyWith(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
