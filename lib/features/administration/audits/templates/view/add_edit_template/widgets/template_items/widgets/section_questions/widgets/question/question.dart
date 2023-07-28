import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionsForSectionView extends StatelessWidget {
  const QuestionsForSectionView({super.key});

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
                Text(
                  'Question',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Score',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const CustomDivider(),
          BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
            builder: (context, state) {
              if (state.sectionItemQuestionListLoadStatus.isLoading) {
                return const Center(child: Loader());
              }

              return ReorderableListView(
                buildDefaultDragHandles: false,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                children: <Widget>[
                  for (int index = 0;
                      index < state.templateQuestionList.length;
                      index += 1)
                    ReorderableDragStartListener(
                      key: Key('$index'),
                      index: index,
                      child: QuestionItemView(
                          question: state.templateQuestionList[index]),
                    ),
                ],
                onReorder: (int oldIndex, int newIndex) {
                  // setState(() {
                  //   if (oldIndex < newIndex) {
                  //     newIndex -= 1;
                  //   }
                  //   final int item = _items.removeAt(oldIndex);
                  //   _items.insert(newIndex, item);
                  // });
                },
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: state.templateQuestionList
                    .map((e) => QuestionItemView(question: e))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
