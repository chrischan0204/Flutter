import '/common_libraries.dart';

class FormItemVertical extends StatelessWidget {
  final Widget leftChild;
  final Widget? rightChild;
  final String leftLabel;
  final String? rightLabel;
  final String leftValidationMessage;
  final String? rightValidationMessage;
  final Widget? secondaryRightChild;
  const FormItemVertical({
    super.key,
    required this.leftChild,
    this.rightChild,
    required this.leftLabel,
    this.rightLabel,
    this.leftValidationMessage = '',
    this.rightValidationMessage = '',
    this.secondaryRightChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: grey))),
      padding: insetx20,
      child: Column(
        children: [
          Padding(
            padding: inset4,
            child: Row(
              children: [
                Text(
                  '',
                  style: textNormal12.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        '$leftLabel:',
                        style: textSemiBold12,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: leftChild,
                    ),
                  ],
                ),
              ),
              spacerx50,
              if (rightChild != null)
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '$rightLabel:',
                          style: textSemiBold12,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: rightChild!,
                      ),
                    ],
                  ),
                ),
              if (secondaryRightChild != null)
                Expanded(child: secondaryRightChild!)
            ],
          ),
          Padding(
            padding: inset4,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          leftValidationMessage,
                          style: textNormal12.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                spacerx50,
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                      if (rightValidationMessage != null)
                        Expanded(
                          flex: 3,
                          child: Text(
                            rightValidationMessage!,
                            style: textNormal12.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
