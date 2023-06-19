import '/common_libraries.dart';

class QuestionsHeaderView extends StatelessWidget {
  final String templateId;
  const QuestionsHeaderView({
    super.key,
    required this.templateId,
  });

  /// get template question details by template section
  void _getTemplateQuestionDetailsByTemplateSection(
      BuildContext context, TemplateSectionListItemForDetail section) {
    context
        .read<TemplateDetailBloc>()
        .add(TemplateDetailSelectionSelected(section: section));
    context.read<TemplateDetailBloc>().add(
          TemplateDetailTemplateQuestionDetailLoaded(
            id: templateId,
            itemType: 1,
            templateSectionId: section.id,
            level: 0,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightBlueAccent,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Questions in this template',
            style: TextStyle(fontSize: 18),
          ),
          BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
            builder: (context, state) {
              Map<String, TemplateSectionListItemForDetail> items = {
                'Show all category questions':
                    const TemplateSectionListItemForDetail(
                        name: 'Show all category questions')
              };
              for (final section in state.templateSectionList) {
                items.addEntries([MapEntry(section.name, section)]);
              }

              return CustomSingleSelect(
                hint: 'Show all category questions',
                width: 400,
                items: items,
                selectedValue: state.selectedTemplateSection?.name,
                onChanged: (section) =>
                    _getTemplateQuestionDetailsByTemplateSection(
                        context, section.value),
              );
            },
          ),
        ],
      ),
    );
  }
}
