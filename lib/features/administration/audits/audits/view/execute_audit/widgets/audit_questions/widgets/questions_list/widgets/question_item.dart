import '/common_libraries.dart';

class QuestionItemView extends StatefulWidget {
  const QuestionItemView({super.key});

  @override
  State<QuestionItemView> createState() => _QuestionItemViewState();
}

class _QuestionItemViewState extends State<QuestionItemView> {
  List<String> responseList = [
    'Poor',
    'Fair',
    'Good',
    'Very Good',
    'Excellent'
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: inset10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: inset20,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Q1: How well do the employees know about social distancing?',
                      style: textSemiBold16,
                    ),
                  ),
                  CustomBadge(
                    label: 'Unanswered',
                    color: warnColor,
                  )
                ],
              ),
            ),
            Row(
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
                            'Assests',
                            style: textNormal14,
                          ),
                        ),
                        for (final response in responseList)
                          CustomBottomBorderContainer(
                            padding: inset20,
                            child: Row(children: [
                              Radio(
                                value: response,
                                groupValue: selectedValue,
                                onChanged: (value) => setState(() {
                                  selectedValue = value;
                                }),
                              ),
                              spacerx20,
                              Text(
                                response,
                                style: textNormal14,
                              ),
                            ]),
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
            ),
          ],
        ),
      ),
    );
  }
}
