import '/common_libraries.dart';

class NewSectionField extends StatefulWidget {
  final String templateId;
  const NewSectionField({
    super.key,
    required this.templateId,
  });

  @override
  State<NewSectionField> createState() => _NewSectionFieldState();
}

class _NewSectionFieldState extends State<NewSectionField> {
  TextEditingController sectionController = TextEditingController();
  late TemplateDesignerBloc templateDesignerBloc;

  @override
  void initState() {
    templateDesignerBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TemplateDesignerBloc, TemplateDesignerState>(
      listener: (context, state) {
        sectionController.text = state.newSection;
        sectionController.selection =
            TextSelection.collapsed(offset: state.newSection.length);
      },
      listenWhen: (previous, current) =>
          previous.newSection != current.newSection,
      child: CustomTextFieldWithIcon(
        hintText: 'Add new section',
        suffixWidget: const Text('Add'),
        onSuffixClicked: () => templateDesignerBloc.add(
            TemplateDesignerTemplateSectionAdded(
                templateId: widget.templateId)),
        onChange: (value) => templateDesignerBloc
            .add(TemplateDesignerNewSectionChanged(newSection: value)),
        controller: sectionController,
      ),
    );
  }
}
