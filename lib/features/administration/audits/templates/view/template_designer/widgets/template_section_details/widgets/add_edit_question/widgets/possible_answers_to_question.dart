import '/common_libraries.dart';

class PossibleAnswersToQuestion extends StatefulWidget {
  final bool child;
  final String templateSectionItemId;

  const PossibleAnswersToQuestion({
    super.key,
    required this.child,
    required this.templateSectionItemId,
  });

  @override
  State<PossibleAnswersToQuestion> createState() =>
      _PossibleAnswersToQuestionState();
}

class _PossibleAnswersToQuestionState extends State<PossibleAnswersToQuestion> {
  late TemplateDesignerBloc templateDesignerBloc;
  String? selectedValue;

  @override
  void initState() {
    templateDesignerBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Possible answers to question:',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const CustomDivider(),
              BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
                builder: (context, state) {
                  Map<String, ResponseScale> items = {};

                  items.addEntries(
                      state.responseScaleList.map((e) => MapEntry(e.name, e)));
                  return CustomSingleSelect(
                    hint: 'Select response scale',
                    selectedValue: selectedValue,
                    items: items,
                    onChanged: (value) {
                      setState(() => selectedValue = value.key);
                      templateDesignerBloc.add(
                        TemplateDesignerResponseScaleItemListLoaded(
                          templateSectionItemId: widget.templateSectionItemId,
                          child: widget.child,
                          responseScaleId: (value.value as ResponseScale).id,
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
