import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddNewQuestionView extends StatefulWidget {
  final TemplateSectionItem templateSectionItem;
  final String templateId;

  const AddNewQuestionView({
    super.key,
    required this.templateSectionItem,
    required this.templateId,
  });

  @override
  State<AddNewQuestionView> createState() => _AddNewQuestionViewState();
}

class _AddNewQuestionViewState extends State<AddNewQuestionView> {
  @override
  void initState() {
    context
        .read<TemplateDesignerBloc>()
        .add(TemplateDesignerResponseScaleListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              AddNewQuestionHeaderView(templateId: widget.templateId),
              QuestionTextField(
                templateSectionItem: widget.templateSectionItem,
              ),
              const ResponseScaleSelectFieldView(),
            ],
          ),
        ),
        ResponseScaleItemListView(
          templateSectionItemList: widget.templateSectionItem.children,
        )
      ],
    );
  }
}
