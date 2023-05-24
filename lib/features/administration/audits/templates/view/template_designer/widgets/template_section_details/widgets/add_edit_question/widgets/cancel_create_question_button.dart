import '/common_libraries.dart';

class CancelCreateQuestionButton extends StatefulWidget {
  const CancelCreateQuestionButton({
    super.key,
  });

  @override
  State<CancelCreateQuestionButton> createState() =>
      _CancelCreateQuestionButtonState();
}

class _CancelCreateQuestionButtonState
    extends State<CancelCreateQuestionButton> {
  late TemplateDesignerBloc templateDesignerBloc;

  @override
  void initState() {
    templateDesignerBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: warnColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            if (state.templateSectionItem?.isNotBlank == true) {
              CustomAlert(
                context: context,
                width: MediaQuery.of(context).size.width / 4,
                title: 'Notification',
                description:
                    'Data entered for question may be lost.... continue?',
                btnOkText: 'OK',
                btnOkOnPress: () => templateDesignerBloc
                    .add(TemplateDesignerCancelCreateQuestionButtonClicked()),
                dialogType: DialogType.info,
              ).show();
            } else {
              templateDesignerBloc
                  .add(TemplateDesignerCancelCreateQuestionButtonClicked());
            }
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
