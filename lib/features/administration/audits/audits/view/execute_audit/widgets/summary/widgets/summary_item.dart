import '/common_libraries.dart';

class SummaryItemView extends StatelessWidget {
  final String title;
  final String content;
  const SummaryItemView({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: grey,
            width: 2,
          ),
          color: lightBlueAccent,
        ),
        child: Column(
          
          children: [
            CustomBottomBorderContainer(
              padding: inset20,
              child: Text(
                title,
                style: textSemiBold14,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: inset20,
              child: Text(
                content,
                style: textSemiBold14,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
