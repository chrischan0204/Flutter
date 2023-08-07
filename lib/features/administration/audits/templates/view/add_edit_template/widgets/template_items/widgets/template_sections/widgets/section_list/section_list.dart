import '/common_libraries.dart';
import 'widgets/widgets.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class SectionListView extends StatelessWidget {
  const SectionListView({
    super.key,
  });

  bool _reorderCallback(Key item, Key newPosition) {
    // int draggingIndex = _indexOfKey(item);
    // int newPositionIndex = _indexOfKey(newPosition);

    // // Uncomment to allow only even target reorder possition
    // // if (newPositionIndex % 2 == 1)
    // //   return false;

    // final draggedItem = _items[draggingIndex];
    // setState(() {
    //   debugPrint("Reordering $item -> $newPosition");
    //   _items.removeAt(draggingIndex);
    //   _items.insert(newPositionIndex, draggedItem);
    // });
    return true;
  }

  void _reorderDone(Key item) {
    // final draggedItem = _items[_indexOfKey(item)];
    // debugPrint("Reordering finished for ${draggedItem.title}}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: grey,
        ),
      ),
      child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
        builder: (context, state) {
          if (state.templateSectionListLoadStatus.isLoading) {
            return const Center(child: Loader());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SummaryView(),
              const CustomDivider(height: 1),
              // for (int index = 0;
              //     index < state.templateSectionList.length;
              //     index++)
              //   SectionItemView(
              //     section: state.templateSectionList[index],
              //     active: state.selectedTemplateSection ==
              //         state.templateSectionList[index],
              //     first: index == 0,
              //   ),

              SizedBox(
                height: 500,
                child: ReorderableList(
                  onReorder: _reorderCallback,
                  onReorderDone: _reorderDone,
                  child: CustomScrollView(
                    // cacheExtent: 3000,
                    slivers: <Widget>[
                      SliverPadding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return SectionItemView(
                                  section: state.templateSectionList[index],
                                  active: state.selectedTemplateSection ==
                                      state.templateSectionList[index],
                                  first: index == 0,
                                );
                              },
                              childCount: state.templateSectionList.length,
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
