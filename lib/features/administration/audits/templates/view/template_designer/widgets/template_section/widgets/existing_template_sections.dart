import '/common_libraries.dart';
import 'template_section_item.dart';

class ExistingTemplateSections extends StatefulWidget {
  const ExistingTemplateSections({super.key});

  @override
  State<ExistingTemplateSections> createState() =>
      _ExistingTemplateSectionsState();
}

class _ExistingTemplateSectionsState extends State<ExistingTemplateSections> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: state.templateSectionList
                    .map((templateSection) => TemplateSectionItemView(
                          templateSection: templateSection,
                          templateSectionItemCount:
                              templateSection.templateSectionItemCount,
                        ))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
