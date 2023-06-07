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
        if (state.templateSectionAddStatus.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
          sectionController.text = '';
        } else if (state.templateSectionAddStatus.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) =>
          previous.templateSectionAddStatus != current.templateSectionAddStatus,
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
                : Icon(
                    PhosphorIcons.regular.arrowCircleRight,
                    color: textColor,
                    size: 18,
                  ),
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
