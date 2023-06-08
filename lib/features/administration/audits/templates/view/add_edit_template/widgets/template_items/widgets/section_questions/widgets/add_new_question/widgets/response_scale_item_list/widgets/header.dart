import '/common_libraries.dart';

class ResponseScaleItemListHeaderView extends StatelessWidget {
  const ResponseScaleItemListHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightBlueAccent,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              'Included?',
              style: textSemiBold14,
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              'Response',
              style: textSemiBold14,
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              'Score',
              style: textSemiBold14,
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              'Further Actions',
              style: textSemiBold14,
            ),
          ),
        ],
      ),
    );
  }
}
