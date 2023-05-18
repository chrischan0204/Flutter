import '/common_libraries.dart';
import 'template_section_item.dart';

class TemplateSectionView extends StatefulWidget {
  final String templateId;
  const TemplateSectionView({
    super.key,
    required this.templateId,
  });

  @override
  State<TemplateSectionView> createState() => _TemplateSectionViewState();
}

class _TemplateSectionViewState extends State<TemplateSectionView> {
  TextEditingController sectionController = TextEditingController();
  late TemplateDesignerBloc templateDesignerBloc;

  @override
  void initState() {
    templateDesignerBloc = context.read()
      ..add(TemplateDesignerTemplateSectionListLoaded(
          templateId: widget.templateId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Template Sections',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const CustomDivider(height: 30),
            Card(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 25,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Add new section',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const CustomDivider(),
                    BlocListener<TemplateDesignerBloc, TemplateDesignerState>(
                      listener: (context, state) {
                        sectionController.text = state.newSection;
                        sectionController.selection = TextSelection.collapsed(
                            offset: state.newSection.length);
                      },
                      listenWhen: (previous, current) =>
                          previous.newSection != current.newSection,
                      child: CustomTextFieldWithIcon(
                        hintText: 'Add new section',
                        suffixWidget: const Text('Add'),
                        onSuffixClicked: () => templateDesignerBloc.add(
                            TemplateDesignerTemplateSectionAdded(
                                templateId: widget.templateId)),
                        onChange: (value) => templateDesignerBloc.add(
                            TemplateDesignerNewSectionChanged(
                                newSection: value)),
                        controller: sectionController,
                      ),
                    ),
                    const CustomDivider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Existing template sections',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const CustomDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.templateSectionList.length,
                          itemBuilder: (context, index) => TemplateSectionItem(
                                sectionName:
                                    state.templateSectionList[index].name,
                                templateSectionItemCount: state
                                    .templateSectionList[index]
                                    .templateSectionItemCount,
                              )),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
