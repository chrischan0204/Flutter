import '/common_libraries.dart';

class ResponseLogicBuilderNameView extends StatelessWidget {
  final TemplateSectionItem templateSectionItem;
  const ResponseLogicBuilderNameView({
    super.key,
    required this.templateSectionItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 20,
      ),
      child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
        builder: (context, state) {
          return Text(
            state.responseScaleList
                .firstWhere(
                  (element) =>
                      element.id == templateSectionItem.responseScaleId,
                  orElse: () => const ResponseScale(
                      id: emptyGuid,
                      name:
                          'Please choose possible answers to question to continue building response logic'),
                )
                .name,
            style: TextStyle(fontSize: 16, color: successColor),
          );
        },
      ),
    );
  }
}
