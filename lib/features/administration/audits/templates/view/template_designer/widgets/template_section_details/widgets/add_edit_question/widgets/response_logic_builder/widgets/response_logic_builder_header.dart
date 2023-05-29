import '/common_libraries.dart';

class ResponseLogicBuilderHeader extends StatelessWidget {
  const ResponseLogicBuilderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: const [
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  'Response',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  'Score',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    'This response requires',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
        const CustomDivider(),
      ],
    );
  }
}
