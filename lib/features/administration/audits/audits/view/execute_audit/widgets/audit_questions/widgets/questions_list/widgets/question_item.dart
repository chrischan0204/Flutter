import '/common_libraries.dart';

class QuestionItemView extends CustomExpansionPanel {
  final String question;
  final String status;
  final List<AuditResponseScaleItem> responseList;
  final int index;
  final bool collapsed;
  QuestionItemView({
    required this.question,
    required this.status,
    required this.responseList,
    required this.index,
    required this.collapsed,
  }) : super(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: insetx12,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Q$index: $question',
                      style: textSemiBold16,
                    ),
                  ),
                  CustomBadge(
                    label: status,
                    color: warnColor,
                  )
                ],
              ),
            );
          },
          backgroundColor: Colors.white,
          isExpanded: collapsed,
          body: BlocProvider(
            create: (context) => ExecuteAuditQuestionBloc(),
            child: QuestionItemBodyView(
              responseList: responseList,
            ),
          ),
        );
}

class QuestionItemBodyView extends StatefulWidget {
  final List<AuditResponseScaleItem> responseList;
  const QuestionItemBodyView({
    super.key,
    required this.responseList,
  });

  @override
  State<QuestionItemBodyView> createState() => _QuestionItemBodyViewState();
}

class _QuestionItemBodyViewState extends State<QuestionItemBodyView> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBottomBorderContainer(
                  padding: insetx12y24,
                  child: Text(
                    'Response',
                    style: textNormal14,
                  ),
                ),
                for (final response in widget.responseList)
                  CustomBottomBorderContainer(
                    padding: inset20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                  value: response.name,
                                  groupValue: selectedValue,
                                  onChanged: (value) => setState(() {
                                        selectedValue = value;
                                      })),
                              spacerx20,
                              Text(
                                response.name,
                                style: textNormal14,
                              ),
                            ],
                          ),
                        ),
                        if (selectedValue == response.name)
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (response.commentRequired == true)
                                  const CustomBadge(
                                    label: 'Comment',
                                    color: Color.fromRGBO(36, 114, 151, 1),
                                  ),
                                if (response.actionItemRequired == true)
                                  const CustomBadge(
                                    label: 'Action Item',
                                    color: Color.fromRGBO(36, 114, 151, 1),
                                  ),
                                if (response.followUpRequired == true)
                                  CustomBadge(
                                    label: 'Follow up ->',
                                    color: primaryColor,
                                  ),
                              ],
                            ),
                          )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBottomBorderContainer(
                  padding: insetx12y24,
                  child: Text(
                    'Assests',
                    style: textNormal14,
                  ),
                ),
                Padding(
                  padding: insetx12y24,
                  child: CustomTabBar(
                    activeIndex: 0,
                    tabs: const {
                      'Observations': Text('Observations'),
                      'Action Items': Text('Action Items'),
                      'Comments': Text('Comments'),
                      'Images/Documents': Text('Images/Documents'),
                    },
                    onTabClick: (index) async {
                      return true;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
