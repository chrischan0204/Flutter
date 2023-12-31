import '/common_libraries.dart';

class SectionQuestionsHeaderView extends StatelessWidget {
  const SectionQuestionsHeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  state.selectedTemplateSection == null
                      ? 'Summary Section'
                      : 'Questions for ${state.selectedTemplateSection!.name}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              spacerx20,
              if (state.selectedTemplateSection != null)
                BlocListener<TemplateDesignerBloc, TemplateDesignerState>(
                  listener: (context, state) {
                    if (state.templateSectionItemCreateStatus.isSuccess) {
                      CustomNotification(
                        context: context,
                        notifyType: NotifyType.success,
                        content: state.message,
                      ).showNotification();

                      context.read<TemplateDesignerBloc>()
                        ..add(const TemplateDesignerAddNewQuestionViewShowed(
                            showAddNewQuestionView: false))
                        ..add(
                          TemplateDesignerTemplateSectionSelected(
                            templateSection: context
                                .read<TemplateDesignerBloc>()
                                .state
                                .selectedTemplateSection,
                          ),
                        );
                    } else if (state
                        .templateSectionItemCreateStatus.isFailure) {
                      CustomNotification(
                        context: context,
                        notifyType: NotifyType.error,
                        content: state.message,
                      ).showNotification();
                    }
                  },
                  listenWhen: (previous, current) =>
                      previous.templateSectionItemCreateStatus !=
                      current.templateSectionItemCreateStatus,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<TemplateDesignerBloc>().add(
                          const TemplateDesignerAddNewQuestionViewShowed(
                              showAddNewQuestionView: true));
                      context
                          .read<TemplateDesignerBloc>()
                          .add(TemplateDesignerNewQuestionButtonClicked());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                    child: Text(
                      state.showAddNewQuestionView
                          ? 'Save Question'
                          : 'Add Question',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
