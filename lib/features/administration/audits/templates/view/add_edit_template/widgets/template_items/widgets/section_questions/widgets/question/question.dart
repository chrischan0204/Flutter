import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionsForSectionView extends StatefulWidget {
  const QuestionsForSectionView({super.key});

  @override
  State<QuestionsForSectionView> createState() =>
      _QuestionsForSectionViewState();
}

class _QuestionsForSectionViewState extends State<QuestionsForSectionView> {
  bool _reorderCallback(Key item, Key newPosition) {
    context
        .read<TemplateDesignerBloc>()
        .add(TemplateDesignerTemplateSectionItemQuestionListSorted(
          currentQuestionId: item,
          newIndex: newPosition,
        ));

    return true;
  }

  void _reorderDone(Key item) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Question',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 60),
                  child: Text(
                    'Score',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const CustomDivider(),
          BlocConsumer<TemplateDesignerBloc, TemplateDesignerState>(
            listener: (context, state) => CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification(),
            listenWhen: (previous, current) =>
                previous.questionDeleteStatus != current.questionDeleteStatus &&
                current.questionDeleteStatus.isSuccess,
            builder: (context, state) {
              if (state.sectionItemQuestionListLoadStatus.isLoading) {
                return const Center(child: Loader());
              }

              return SizedBox(
                height: 50.0 * state.templateQuestionList.length,
                child: ReorderableList(
                  onReorder: _reorderCallback,
                  onReorderDone: _reorderDone,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return QuestionItemView(
                                question: state.templateQuestionList[index],
                                isFirst: index == 0,
                                isLast: index ==
                                    state.templateQuestionList.length - 1,
                              );
                            },
                            childCount: state.templateQuestionList.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
