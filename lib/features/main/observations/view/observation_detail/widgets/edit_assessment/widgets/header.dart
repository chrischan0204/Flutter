

import '/common_libraries.dart';

class AssessmentHeaderView extends StatelessWidget {
  const AssessmentHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset20,
      color: lightBlueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Assessment Reading',
            style: textNormal14,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            child: Text(
              'Edit Assessment',
              style: textNormal12.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
