import '/common_libraries.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    return BlocConsumer<TemplateDesignerBloc, TemplateDesignerState>(
      listener: (context, state) {
        sectionController.text = state.newSection;
        sectionController.selection =
            TextSelection.collapsed(offset: state.newSection.length);
      },
      listenWhen: (previous, current) =>
          previous.newSection != current.newSection,
      builder: (context, state) => CustomTextFieldWithIcon(
        hintText: 'Add new section',
        suffixWidget: SizedBox(
          width: 40,
          child: Center(
            child: state.templateSectionAddStatus.isLoading
                ? LoadingAnimationWidget.inkDrop(
                    color: Colors.blue,
                    size: 20,
                  )
                : const Text('Add'),
          ),
        ),
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
