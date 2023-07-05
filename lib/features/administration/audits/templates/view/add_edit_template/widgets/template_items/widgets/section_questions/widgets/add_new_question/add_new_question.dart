import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddNewQuestionView extends StatefulWidget {
  final TemplateSectionItem templateSectionItem;

  const AddNewQuestionView({
    super.key,
    required this.templateSectionItem,
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
    return BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
      builder: (context, state) {
        if (state.questionDetailLoadStatus.isLoading) {
          return const Center(child: Loader());
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const AddNewQuestionHeaderView(),
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
      },
    );
  }
}
