import '/common_libraries.dart';

class SaveQuestionButton extends StatefulWidget {
  const SaveQuestionButton({
    super.key,
  });

  @override
  State<SaveQuestionButton> createState() => _SaveQuestionButtonState();
}

class _SaveQuestionButtonState extends State<SaveQuestionButton> {
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
        CustomNotification(
          context: context,
          notifyType: NotifyType.success,
          content: state.message,
        ).showNotification();
      },
      listenWhen: (previous, current) =>
          previous.templateSectionItemCreateStatus !=
              current.templateSectionItemCreateStatus &&
          current.templateSectionItemCreateStatus.isSuccess,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: successColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () => templateDesignerBloc
            .add(TemplateDesignerTemplateSectionItemCreated()),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            'Save Question',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}